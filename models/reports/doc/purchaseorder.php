<?php
/*
   Name of Page: doc reports purchase order data source

   Method: It provides data from database for docreports pages

   Date created: Nikita Zaharov, 24.04.2016

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

   Last Modified: 24.04.2016
   Last Modified by: Nikita Zaharov
 */

namespace App\Models;

use Illuminate\Support\Facades\DB;
use Session;

function numberToStr($strin){
    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $strin);
}

class docReportsData{
    protected $id = ""; //purchase number

    public function __construct($id){
        $this->id = $id;
    }

    public function getCurrencySymbol(){
        $user = Session::get("user");

        $result =  DB::select("select I.CurrencyID, C.CurrenycySymbol from PurchaseHeader I, CurrencyTypes C WHERE I.CurrencyID=C.CurrencyID and I.PurchaseNumber='" . $this->id . "' and I.CompanyID='" . $user["CompanyID"] . "' and I.DivisionID='" . $user["DivisionID"] . "' and I.DepartmentID='" . $user["DepartmentID"] . "'", array());

        return [
            "id" => count($result) ? $result[0]->CurrencyID : "USD",
            "symbol" => count($result) ? $result[0]->CurrenycySymbol : "$"
        ];
    }

    public function getUser(){
        $user = Session::get("user");
        $user["company"] = DB::select("SELECT * from companies WHERE CompanyID='" . $user["CompanyID"] ."' and DivisionID='" . $user["DivisionID"] . "' and DepartmentID='" . $user["DepartmentID"] . "'", array())[0];
        
        return $user;
    }

    public function getHeaderData(){
        $user = Session::get("user");
        
        $conn =  DB::connection()->getPdo();
        $stmt = $conn->prepare("CALL RptDocPurchaseOrderHeaderSingle('". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "', '" . $this->id . "')");
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
        $stmt = $conn->prepare("CALL RptDocPurchaseOrderDetailSingle('". $user["CompanyID"] . "','". $user["DivisionID"] ."','" . $user["DepartmentID"] . "', '" . $this->id . "')");
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