<?php
/*
Name of Page: gridDataSource class

Method: ancestor for GeneralLedger/* models. It provides data from database

Date created: Nikita Zaharov, 17.02.2016

Use: this model used for
- for loading data from tables, updating, inserting and deleting

Input parameters:
$db: database instance
methods has own parameters

Output parameters:
- methods has own output

Called from:
inherited by models/GeneralLedger/*

Calls:
sql

Last Modified: 23.02.2016
Last Modified by: Nikita Zaharov
*/

namespace App\Models;

use Illuminate\Support\Facades\DB;
use Session;

class gridDataSource{
    protected $tableName = "";
    //fields to render in grid
    protected $gridFields = [];

    public $idField = "";

    //getting list of available ledger transaction types 
    public function getLedgerTransactionTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT TransactionTypeID,TransactionTypeDescription from ledgertransactiontypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->TransactionTypeID] = [
                "title" => $value->TransactionTypeID,
                "value" => $value->TransactionTypeID
            ];
        
        return $res;
    }

    //getting list of available transaction types 
    public function getBankTransactionTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT BankTransactionTypeID,BankTransactionTypeDesc from banktransactiontypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->BankTransactionTypeID] = [
                "title" => $value->BankTransactionTypeID,
                "value" => $value->BankTransactionTypeID
            ];
        
        return $res;
    }
    
    //getting list of available account types 
    public function getAccounts(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT GLAccountNumber,GLAccountName from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->GLAccountNumber] = [
                "title" => $value->GLAccountNumber . ", " . $value->GLAccountName,
                "value" => $value->GLAccountNumber
            ];
        return $res;
    }
    
    //getting list of available values for GLAccountType 
    public function getCurrencyTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT CurrencyID,CurrencyType from currencytypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->CurrencyID] = [
                "title" => $value->CurrencyID . ", " . $value->CurrencyType,
                "value" => $value->CurrencyID
            ];
        
        return $res;
    }
    
    //getting rows for grid
    public function getPage($number){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->gridFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->idFields as $key){
            switch($key){
            case "CompanyID" :
                $keyFields .= "CompanyID='" . $user["CompanyID"] . "' AND ";
                break;
            case "DivisionID" :
                $keyFields .= "DivisionID='" . $user["DivisionID"] . "' AND ";
                break;
            case "DepartmentID" :
                $keyFields .= "DepartmentID='" . $user["DepartmentID"] . "' AND ";
                break;
            }
            if(!in_array($key, $fields))
                $fields[] = $key;                
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    //getting data for grid edit form 
    public function getEditItem($id, $type){
        $user = Session::get("user");
        $columns = [];
        foreach($this->editCategories[$type] as $key=>$value){
            $columns[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $columns[] = $addfield;
            }
        }
        
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = DB::select("SELECT " . implode(",", $columns) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true)[0];
        
        return $result;        
    }

    //getting data for new record
    public function getNewItem($id, $type){
        $values = [];
        if(Session::has("GL" . $this->tableName . "New"))
            foreach(Session::get("GL" . $this->tableName . "New")["$type"] as $key=>$value)
                $values[$key] = $value["defaultValue"];
        else{
            Session::put("GL" . $this->tableName . "New", $this->editCategories);
            $values = [];
            foreach($this->editCategories[$type] as $key=>$value)
                $values[$key] = $value["defaultValue"];
        }
        return $values;
    } 

    //getting data for grid view form
    public function getItem($id){
        $user = Session::get("user");
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = DB::select("SELECT " . implode(",", $this->gridFields) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        return json_decode(json_encode($result), true)[0];
    }

    //updating data of grid item
    public function updateItem($id, $category, $values){
        $user = Session::get("user");
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        $update_fields = "";
        foreach($this->editCategories[$category] as $name=>$value){
            if(key_exists($name, $values)){
                if($value["inputType"] == 'timestamp' || $value["inputType"] == 'datetime')
                    $values[$name] = date("Y-m-d H:i:s", strtotime($values[$name]));
                else if(key_exists("formatFunction", $value)){
                    $formatFunction = $value["formatFunction"];
                    $values[$name] = $this->$formatFunction($values, "editCategories", $name, $values[$name], true);
                }
                if(key_exists("format", $value) && preg_match('/decimal/', $value["dbType"]))
                    $values[$name] = str_replace(",", "", $values[$name]);

                if($update_fields == "")
                    $update_fields = $name . "='" . $values[$name] . "'";
                else
                    $update_fields .= "," . $name . "='" . $values[$name] . "'";
            }
        }

        DB::update("UPDATE " . $this->tableName . " set " . $update_fields .  ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }

    //add row to table
    public function insertItem($values){
        $user = Session::get("user");
        
        $insert_fields = "";
        $insert_values = "";
        foreach($this->editCategories as $category=>$arr){
            foreach($this->editCategories[$category] as $name=>$value){
                if(key_exists($name, $values)){
                    if($value["inputType"] == 'timestamp' || $value["inputType"] == 'datetime')
                        $values[$name] = date("Y-m-d H:i:s", strtotime($values[$name]));
                    else if(key_exists("formatFunction", $value)){
                        $formatFunction = $value["formatFunction"];
                        $values[$name] = $this->$formatFunction($values, "editCategories", $name, $values[$name], true);
                    }
                    if(key_exists("format", $value) && preg_match('/decimal/', $value["dbType"]))
                        $values[$name] = str_replace(",", "", $values[$name]);

                    if($insert_fields == ""){
                        $insert_fields = $name;
                        $insert_values = "'" . $values[$name] . "'";
                    }else{
                        $insert_fields .= "," . $name;
                        $insert_values .= ",'" . $values[$name] . "'";
                    }
                }
            }
        }

        $insert_fields .= ',CompanyID,DivisionID,DepartmentID';
        $insert_values .= ",'" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "'";
        DB::insert("INSERT INTO " . $this->tableName . "(" . $insert_fields . ") values(" . $insert_values .")");
    }

    //delete row from table
    public function deleteItem($id){
        $user = Session::get("user");
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        DB::delete("DELETE from " . $this->tableName .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }

    protected $currencyPrecisions = [];
    
    //formatting and getting raw values for currency fields
    public function currencyFormat($values, $fieldContainer, $fieldName, $value, $in){
        $user = Session::get("user");
        if($in)
            return str_replace(",", "", $value);
        else {
            if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts)){
                $desc = false;
                if($fieldContainer == "gridFields"){
                    foreach($this->gridFields as $key=>$_desc)
                        if($key == $fieldName)
                            $desc = $_desc;
                }else if($fieldContainer == "editCategories"){
                    foreach($this->editCategories as $category){
                        foreach($category as $key=>$_desc)
                            if($key == $fieldName)
                                $desc = $_desc;
                    }
                }
                if($desc && key_exists("currencyField", $desc)){
                    if(key_exists($values[$desc["currencyField"]], $this->currencyPrecisions))
                        $result = $this->currencyPrecisions[$values[$desc["currencyField"]]];
                    else 
                        $this->currencyPrecisions[$values[$desc["currencyField"]]] = $result = DB::select("SELECT CurrencyPrecision from currencytypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND CurrencyID='" . $values[$desc["currencyField"]] . "'" , array());
                    //return json_encode($result);
                    if($result)
                        return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $numberParts[1]) . '.' . substr($numberParts[2], 0, $result[0]->CurrencyPrecision < 5 ? $result[0]->CurrencyPrecision : 2);
                    else
                        return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $numberParts[1]) . '.' . substr($numberParts[2], 0, 2);
                }
            }
        }
        return $value;
    }
}

?>