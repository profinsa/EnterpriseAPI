<?php
/*
   Name of Page: doc reports creditmemo data source

   Method: It provides data from database for docreports pages

   Date created: Nikita Zaharov, 20.04.2016

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

   Last Modified: 05.05.2016
   Last Modified by: Nikita Zaharov
 */

function numberToStr($strin){
    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $strin);
}

class docReportsData{
    protected $id = ""; //invoice number

    public function __construct($id){
        $this->id = $id;
    }

    public function getCurrencySymbol(){
        $user = $_SESSION["user"];

        $result =  $GLOBALS["capsule"]::select("select I.CurrencyID, C.CurrenycySymbol from InvoiceHeader I, CurrencyTypes C WHERE I.CurrencyID=C.CurrencyID and I.OrderNumber='" . $this->id . "' and I.CompanyID='" . $user["CompanyID"] . "' and I.DivisionID='" . $user["DivisionID"] . "' and I.DepartmentID='" . $user["DepartmentID"] . "'", array());

        return [
            "id" => count($result) ? $result[0]->CurrencyID : "USD",
            "symbol" => count($result) ? $result[0]->CurrenycySymbol : "$"
        ];
    }

    public function getUser(){
        $user = $_SESSION["user"];

        $user["company"] = $GLOBALS["capsule"]::select("SELECT * from companies WHERE CompanyID='" . $user["CompanyID"] ."' and DivisionID='" . $user["DivisionID"] . "' and DepartmentID='" . $user["DepartmentID"] . "'", array())[0];
        
        return $user;
    }

    public function getHeaderData(){
        $user = $_SESSION["user"];
        
        $conn =  $GLOBALS["capsule"]::connection()->getPdo();
        $stmt = $conn->prepare("CALL RptDocCreditHeaderSingle('". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "', '" . $this->id . "')");
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
        $user = $_SESSION["user"];
        
        $conn =  $GLOBALS["capsule"]::connection()->getPdo();
        $stmt = $conn->prepare("CALL RptDocCreditDetailSingle('". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "', '" . $this->id . "')");
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
