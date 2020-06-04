<?php
/*
  Name of Page: doc reports payment data source

  Method: It provides data from database for docreports pages

  Date created: Nikita Zaharov, 01.09.2019

  Use: this model used for 
  - for loading data using stored procedures

  Input parameters:
  $capsule: database instance
  methods has own parameters

  Output parameters:
  - methods has own output

  Called from:
  controllers/docreports

  Calls:
  sql

  Last Modified: 01.09.2019
  Last Modified by: Nikita Zaharov
*/

require "docreportsbase.php";

function numberToStr($strin){
    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $strin);
}

class docReportsData extends docReportsBase{
    protected $id = ""; //invoice number
    public $tableName = "paymentsheader";
    public $keyField = "PaymentID";

    public function __construct($id){
        $this->id = $id;
    }

    public function getHeaderData(){
        $user = Session::get("user");
        
        $conn =  DB::connection()->getPdo();
        $stmt = $conn->prepare("CALL RptDocPaymentsHeaderSingle('". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "', '" . $this->id . "')");
        $rs = $stmt->execute();
        $result = $stmt->fetchAll($conn::FETCH_ASSOC);

        $meta = [];
        $mcounter = 0;
        foreach($result[0] as $key=>$value){
            $meta[$key] = $stmt->getColumnMeta($mcounter++);
        }
        
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
        return $result[0];
    }

    public function getDetailData(){
        $user = Session::get("user");
        
        $conn =  DB::connection()->getPdo();
        $stmt = $conn->prepare("CALL RptDocPaymentsDetailSingle('". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "', '" . $this->id . "')");
        $rs = $stmt->execute();
        $result = $stmt->fetchAll($conn::FETCH_ASSOC);

        if(!count($result))
            return false;
        
        $meta = [];
        $mcounter = 0;
        foreach($result[0] as $key=>$value){
            $meta[$key] = $stmt->getColumnMeta($mcounter++);
        }
        
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

        return $result;
    }
}
?>