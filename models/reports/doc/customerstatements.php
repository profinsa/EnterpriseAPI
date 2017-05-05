<?php
/*
Name of Page: doc reports customer statements data source

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
    protected $id = ""; //customer id

    public function __construct($id){
        $this->id = $id;
    }

    public function getCurrencySymbol(){
        $user = Session::get("user");

        //        $result =  DB::select("select I.CurrencyID, C.CurrencySymbol from CustomerInformation I, CurrencyTypes C WHERE I.CurrencyID=C.CurrencyID and I.CustomerID='" . $this->id . "' and I.CompanyID='" . $user["CompanyID"] . "' and I.DivisionID='" . $user["DivisionID"] . "' and I.DepartmentID='" . $user["DepartmentID"] . "'", array());
        $result = [];
        
        return [
            "id" => count($result) ? $result[0]->CurrencyID : "USD",
            "symbol" => count($result) ? $result[0]->CurrencySymbol : "$"
        ];
    }

    public function getUser(){
        $user = Session::get("user");
        $user["company"] = DB::select("SELECT * from companies WHERE CompanyID='" . $user["CompanyID"] ."' and DivisionID='" . $user["DivisionID"] . "' and DepartmentID='" . $user["DepartmentID"] . "'", array())[0];
        
        return $user;
    }

    public function getData(){
        $user = Session::get("user");
        
        $conn =  DB::connection()->getPdo();
        //        $stmt = $conn->prepare("CALL RptCustomerStatement('" . $user["CompanyID"] . "', '" . $user["DivisionID"] . "', '" . $user["DepartmentID"] . "', '" . $this->id . "', :name, :addr1, :addr2, :addr3, :city, :state, :zip, :country, :Balance, :Ret)",array($conn::MYSQL_ATTR_USE_BUFFERED_QUERY => true));
        $stmt = $conn->prepare("CALL RptCustomerStatement('" . $user["CompanyID"] . "', '" . $user["DivisionID"] . "', '" . $user["DepartmentID"] . "', '" . $this->id . "', @name, @addr1, @addr2, @addr3, @city, @state, @zip, @country, @balance, @Ret)",array($conn::MYSQL_ATTR_USE_BUFFERED_QUERY => true));

        /*        $stmt->bindParam("1", $name, $conn::PARAM_INPUT_OUTPUT);
        $stmt->bindParam("2", $Address1, $conn::PARAM_STR|$conn::PARAM_INPUT_OUTPUT, 4000);
        $stmt->bindParam("3", $Address2, $conn::PARAM_STR|$conn::PARAM_INPUT_OUTPUT, 4000);
        $stmt->bindParam("4", $Address3, $conn::PARAM_STR|$conn::PARAM_INPUT_OUTPUT, 4000);
        $stmt->bindParam("5", $City, $conn::PARAM_STR|$conn::PARAM_INPUT_OUTPUT, 4000);
        $stmt->bindParam("6", $State, $conn::PARAM_STR|$conn::PARAM_INPUT_OUTPUT, 4000);
        $stmt->bindParam("7", $Zip, $conn::PARAM_STR|$conn::PARAM_INPUT_OUTPUT, 4000);
        $stmt->bindParam("8", $country, $conn::PARAM_STR|$conn::PARAM_INPUT_OUTPUT, 4000);
        $stmt->bindParam("9", $balance, $conn::PARAM_INPUT_OUTPUT);
        $stmt->bindParam("10", $retu, $conn::PARAM_INPUT_OUTPUT);*/
        $rs = $stmt->execute();
        $result = $stmt->fetchAll($conn::FETCH_ASSOC);
        //        $stmt->closeCursor();
       
        if(count($result)){
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
        }
        
        
        $stmt = null;
        $st = $conn->prepare("select @name, @addr1, @addr2, @addr3, @city, @state, @zip, @country, @Balance");
        $st->execute();

        return [
            "customer" => $st->fetchAll($conn::FETCH_ASSOC)[0],
            "transactions" => $result
        ];
    }
}
?>