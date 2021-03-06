<?php
/*
   Name of Page: doc reports order data source

   Method: It provides data from database for docreports pages

   Date created: Nikita Zaharov, 19.04.2017

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

   Last Modified: 22.07.2020
   Last Modified by: Nikita Zaharov
 */

require "docreportsbase.php";

function numberToStr($strin){
    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $strin);
}

class docReportsData extends docReportsBase{
    protected $id = ""; //order number
    public $tableName = "orderheader";
    public $keyField = "OrderNumber";

    public function __construct($id){
        $this->id = $id;
    }

    public function getHeaderData(){
        $user = $_SESSION["user"];

        $dbName = DB::getDatabaseName();
        $conn =  $GLOBALS["capsule"]::connection()->getPdo();
        if($GLOBALS["config"]["db_type"] == "mysql")
            $stmt = $conn->prepare("CALL RptDocOrderHeaderSingle('". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "', '" . $this->id . "')");
        else if($GLOBALS["config"]["db_type"] == "sqlsrv")
            $stmt = $conn->prepare("EXEC $dbName.RptDocOrderHeaderSingle '". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "', '" . $this->id . "'");

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
                if($meta[$key]["native_type"] == "NEWDECIMAL" ||
                   $meta[$key]["native_type"] == "DECIMAL" ||
                   $meta[$key]["native_type"] == "money"){
                    $afterdot = 2;
                    if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts))
                        $result[$rkey][$key] = numberToStr($numberParts[1]) . '.' . substr($numberParts[2], 0, $afterdot);
                }
                if($meta[$key]["native_type"] == "TIMESTAMP" ||
                   $meta[$key]["native_type"] == "DATETIME" ||
                   $meta[$key]["native_type"] == "timestamp" ||
                   $meta[$key]["native_type"] == "datetime")
                    if($value != "")
                        $result[$rkey][$key] = date("m/d/y", strtotime($value));
            }
        }

        return $result[0];
    }

    public function getDetailData(){
        $user = $_SESSION["user"];
        
        $dbName = DB::getDatabaseName();
        $conn =  $GLOBALS["capsule"]::connection()->getPdo();
        if($GLOBALS["config"]["db_type"] == "mysql")
            $stmt = $conn->prepare("CALL RptDocOrderDetailSingle('". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "', '" . $this->id . "')");
        else if($GLOBALS["config"]["db_type"] == "sqlsrv")
            $stmt = $conn->prepare("EXEC $dbName.RptDocOrderDetailSingle '". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "', '" . $this->id . "'");
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
                if($meta[$key]["native_type"] == "NEWDECIMAL" ||
                   $meta[$key]["native_type"] == "DECIMAL" ||
                   $meta[$key]["native_type"] == "money"){
                    $afterdot = 2;
                    if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts))
                        $result[$rkey][$key] = numberToStr($numberParts[1]) . '.' . substr($numberParts[2], 0, $afterdot);
                }
                if($meta[$key]["native_type"] == "TIMESTAMP" ||
                   $meta[$key]["native_type"] == "DATETIME" ||
                   $meta[$key]["native_type"] == "timestamp" ||
                   $meta[$key]["native_type"] == "datetime")
                    if($value != "")
                        $result[$rkey][$key] = date("m/d/y", strtotime($value));
            }
        }

        return $result;
    }
}
?>
