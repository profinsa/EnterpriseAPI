<?php
/*
Name of Page: autoreports data sourcee

Method: It provides data from database for autoreports page

Date created: Nikita Zaharov, 10.04.2016

Use: this model used for 
- getting columns of table
- for loading data using stored procedures

Input parameters:
$capsule: database instance
methods has own parameters

Output parameters:
- methods has own output

Called from:
controllers/autoreports

Calls:
sql

Last Modified: 17.04.2016
Last Modified by: Nikita Zaharov
*/

function numberToStr($strin){
    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $strin);
}


class autoreportsData{
    protected $reportName = "";
    protected $datasortOption = [];

    public function __construct($reportName){
        $this->reportName = $reportName;
    }

    public function getOperators(){
        return [">", ">=", "<", "<=", "=", "!=", "LIKE"];
    }

    public function getParameters(){
        $user = $_SESSION["user"];
        $dbname = $GLOBALS["capsule"]::connection()->getDatabaseName();
        $result = $GLOBALS["capsule"]::select("SELECT * FROM information_schema.parameters WHERE SPECIFIC_NAME = '" . $this->reportName . "'");
        $params = [];
        foreach($result as $value)
            if($value->SPECIFIC_SCHEMA == $dbname)
                $params[] = $value;
        return $params;
    }

    public function getParametersForEnter(){
        $user = $_SESSION["user"];
        $dbname = $GLOBALS["capsule"]::connection()->getDatabaseName();
        $result = $GLOBALS["capsule"]::select("SELECT * FROM information_schema.parameters WHERE SPECIFIC_NAME = '" . $this->reportName . "'");
        $params = [];
        $count = 0;
        foreach($result as $value){
            if($value->SPECIFIC_SCHEMA == $dbname){
                if($count > 2 && $value->PARAMETER_MODE == "IN")
                    $params[] = $value;
                $count++;
            }
        }
        return $params;
    }
    
    public function getColumns(){
        $user = $_SESSION["user"];
        $params = $this->getParameters();
        $optional = "";
        $paramsCount = count($params);

        if($paramsCount > 3){
            $pcount = 0;
            array_splice($params, 0, 3);
            foreach($params as $param){
                if($param->PARAMETER_MODE == "INOUT" || $param->PARAMETER_MODE == "INOUT")
                    $optional .= ", @PARAM" . $pcount++;
                else
                    $optional .= ", '" . $_GET[$param->PARAMETER_NAME] . "'";
            }
        }
        
        $conn =  $GLOBALS["capsule"]::connection()->getPdo();
        $stmt = $conn->prepare("CALL " . $this->reportName . "('". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "'" . $optional . ")");
        $rs = $stmt->execute();
        $result = $stmt->fetchAll($conn::FETCH_ASSOC);
        //        $result = DB::select("CALL " . $this->reportName . "('". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "')", array());

        if(count($result)){
            $meta = [];
            $mcounter = 0;
            foreach($result[0] as $key=>$value)
                $meta[$key] = $stmt->getColumnMeta($mcounter++);

            if(count($result)){
                foreach($result[0] as $key=>$value)
                    $columns[$key] = $meta[$key];
            }
        
            return $columns;
            //        return [];
        }else{
            return false;
        }
    }

    protected function datacmp($a, $b){
        if($a[$this->datasortOption["field"]] == $b[$this->datasortOption["field"]])
            return 0;
        if($a[$this->datasortOption["field"]] < $b[$this->datasortOption["field"]])
            return -1;
        else
            return 1;
    }
    
    public function getData($nototal=false){
        $user = $_SESSION["user"];
        $params = $this->getParameters();
        $optional = "";
        $paramsCount = count($params);

        if($paramsCount > 3){
            $pcount = 0;
            array_splice($params, 0, 3);
            foreach($params as $param){
                if($param->PARAMETER_MODE == "INOUT" || $param->PARAMETER_MODE == "INOUT")
                    $optional .= ", @PARAM" . $pcount++;
                else
                    $optional .= ", '" . $_GET[$param->PARAMETER_NAME] . "'";
            }
        }
        
        $columns = $this->getColumns();
        $options = [];
        foreach($columns as $column=>$value)
            if(key_exists($column, $_GET))
                $options[$column] = explode(",", $_GET[$column]);
        
        $conn =  $GLOBALS["capsule"]::connection()->getPdo();
        $stmt = $conn->prepare("CALL " . $this->reportName . "('". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "'" . $optional . ")");
        $rs = $stmt->execute();
        $result = $stmt->fetchAll($conn::FETCH_ASSOC);
        //        $result = DB::select("CALL " . $this->reportName . "('". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "')", array());

        $meta = [];
        $mcounter = 0;
        $totalRow = [];
        foreach($result[0] as $key=>$value){
            $meta[$key] = $stmt->getColumnMeta($mcounter++);
            $totalRow[$key] = "";
        }
        //                echo json_encode($meta);

        //applying show and search operators
        $rkey = count($result) - 1;
        while($rkey >= 0){
            $row = $result[$rkey];
            foreach($options as $key=>$option){
                if(!key_exists($rkey, $result))
                    break;
                if($option[0] == "False"){//show|hide
                    unset($result[$rkey][$key]);
                    unset($totalRow[$key]);
                    continue;
                }

                if($option[4] && $option[4] != 'None'){//applying search operators
                    $cmpvalue = 0;
                    $tocmpvalue = 0; 
                    if($meta[$key]["native_type"] == "NEWDECIMAL" ||
                       $meta[$key]["native_type"] == "DECIMAL" ||
                       $meta[$key]["native_type"] == "TINYINT"){
                        $cmpvalue = intval($result[$rkey][$key]);
                        $tocmpvalue = intval($option[5]);
                    }else{
                        $cmpvalue = $result[$rkey][$key];
                        $tocmpvalue = $option[5];
                    }
                    //                    echo "ddfdf";
                    switch($option[4]){
                    case "M" :
                        if($cmpvalue <= $tocmpvalue)
                            array_splice($result,$rkey,1);
                        break;
                    case "MEQ" :
                        if($cmpvalue < $tocmpvalue)
                            array_splice($result,$rkey,1);
                        break;
                    case "L" :
                        if($cmpvalue >= $tocmpvalue)
                            array_splice($result,$rkey,1);
                        break;
                    case "LEQ" :
                        if($cmpvalue > $tocmpvalue)
                            array_splice($result,$rkey,1);
                        break;
                    case "EQ" :
                        if($cmpvalue != $tocmpvalue)
                            array_splice($result,$rkey,1);
                        break;
                    case "NEQ" :
                        if($cmpvalue == $tocmpvalue)
                            array_splice($result,$rkey,1);
                        break;
                    case "LIKE" :

                        break;
                    }
                }
            }
            $rkey--;
        }

        //calculating total
        foreach($result as $row){
            foreach($options as $key=>$option){
                if($option[1] == "True"){//total
                    if($totalRow[$key] == "")
                        $totalRow[$key] = 0;
                    $totalRow[$key] += $row[$key];
                }
            }
        }

        //sorting data
        $sortArr = [];
        $srind = 0;
        foreach($options as $key=>$option){
            if($option[2] > 0){
                $sortArr[intval($option[2])] = [$key, $option[3]];
            }
        }

        foreach($sortArr as $key=>$sort){
            //            echo "EEEEEEEEEE" . $key;
            /*            $this->datasortOption["field"] = $sortArr[$srind][0];
            $this->datasortOption["direction"] = $sortArr[$srind][1];
            if(key_exists($this->datasortOption["field"], $result))
            uasort($result, array($this, 'datacmp'));*/
            $srind++;
        }
        //        echo json_encode($sortOptions);

        //        if($this->datasortOption["direction"] == "DESC")
        //  $result = array_reverse($result);

        /*        $totalEmptyFlag = true;
        foreach($totalRow as $tfield){
            if($tfield != "")
                $totalEmptyFlag = false;
        }                    
        if(!$totalEmptyFlag)*/
        if(!$nototal)
            $result[] = $totalRow;

        //formatting data
        foreach($result as $rkey=>$row){
            foreach($row as $key=>$value){
                if($meta[$key]["native_type"] == "NEWDECIMAL" || $meta[$key]["native_type"] == "DECIMAL"){
                    $afterdot = 2;
                    if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts))
                        $result[$rkey][$key] = numberToStr($numberParts[1]) . '.' . substr($numberParts[2], 0, $afterdot);
                }
                if($meta[$key]["native_type"] == "TIMESTAMP" || $meta[$key]["native_type"] == "DATETIME")
                    if($value != "")
                        $result[$rkey][$key] = date("m/d/y", strtotime($value));
            }
        }
        
        //        echo json_encode($res);
        return $result;
    }
    
}