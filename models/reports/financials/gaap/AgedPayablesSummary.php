<?php
/*
Name of Page: doc financials gaap aged payables summary data source

Method: It provides data from database for docreports pages

Date created: Nikita Zaharov, 25.04.2016

Use: this model used for 
- for loading data using stored procedures

Input parameters:
$capsule: database instance
methods has own parameters

Output parameters:
- methods has own output

Called from:
controllers/financials

Calls:
sql

Last Modified: 11.05.2016
Last Modified by: Nikita Zaharov
*/

function numberToStr($strin){
    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $strin);
}

function gridFormatFields($stmt, $result){
    if(count($result)){
        $meta = [];
        $mcounter = 0;
        foreach($result[0] as $key=>$value){
            $meta[$key] = $stmt->getColumnMeta($mcounter++);
        }
        
        //formatting data
        foreach($result as $rkey=>$row){
            foreach($row as $key=>$value){
                if($meta[$key]["native_type"] == "NEWDECIMAL" || $meta[$key]["native_type"] == "DECIMAL" || $meta[$key]["native_type"] == "LONGLONG"){
                    $afterdot = 2;
                    if($meta[$key]["native_type"] == "LONGLONG")
                        $result[$rkey][$key] = numberToStr($value) . ".00";
                    else if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts))
                        $result[$rkey][$key] = numberToStr($numberParts[1]) . '.' . substr($numberParts[2], 0, $afterdot);
                }
                if($meta[$key]["native_type"] == "TIMESTAMP" || $meta[$key]["native_type"] == "DATETIME")
                    if($value != "")
                        $result[$rkey][$key] = date("m/d/y", strtotime($value));
            }
        }
    }
    return $result;
}

class financialsReportData{
    protected $id = ""; //customer id

    public $title = "GAAP Aged Payables Summary Report";
    public function __construct($id){
        $this->id = $id;
    }

    public function getCurrencySymbol(){
        $user = $_SESSION["user"];

        //        $result =  $GLOBALS["capsule"]::select("select I.CurrencyID, C.CurrencySymbol from CustomerInformation I, CurrencyTypes C WHERE I.CurrencyID=C.CurrencyID and I.CustomerID='" . $this->id . "' and I.CompanyID='" . $user["CompanyID"] . "' and I.DivisionID='" . $user["DivisionID"] . "' and I.DepartmentID='" . $user["DepartmentID"] . "'", array());
        $result = [];
        
        return [
            "id" => count($result) ? $result[0]->CurrencyID : "USD",
            "symbol" => count($result) ? $result[0]->CurrencySymbol : "$"
        ];
    }

    public function getUser(){
        $user = $_SESSION["user"];
        
        $user["company"] = $GLOBALS["capsule"]::select("SELECT * from companies WHERE CompanyID='" . $user["CompanyID"] ."' and DivisionID='" . $user["DivisionID"] . "' and DepartmentID='" . $user["DepartmentID"] . "'", array())[0];
        
        return $user;
    }

    public function getData(){
        $user = $_SESSION["user"];
        
        $conn =  $GLOBALS["capsule"]::connection()->getPdo();
        $conn->setAttribute($conn::ATTR_EMULATE_PREPARES, true);
$stmt = $conn->prepare("CALL RptGLAgedPayablesDetail('" . $user["CompanyID"] . "', '" . $user["DivisionID"] . "', '" . $user["DepartmentID"] . "', @ret)",array($conn::MYSQL_ATTR_USE_BUFFERED_QUERY => true));

        $rs = $stmt->execute();

        $summary = $stmt->fetchAll($conn::FETCH_ASSOC);
        $summary = gridFormatFields($stmt, $summary);

        $stmt->nextRowset();
        $totals = $stmt->fetchAll($conn::FETCH_ASSOC);
        $totals = gridFormatFields($stmt, $totals);

        $stmt->nextRowset();
        $details = $stmt->fetchAll($conn::FETCH_ASSOC);
        $details = gridFormatFields($stmt, $details);
        
        $stmt = null;

        
        
        return [
            "summary" => $summary,
            "totals" => $totals,
            "details" => $details
        ];
    }
}
?>