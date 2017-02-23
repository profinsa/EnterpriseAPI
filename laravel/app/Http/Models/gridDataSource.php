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
    
    //getting list of available transaction types 
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
        $result = DB::select("SELECT " . implode(",", $this->gridFields) . " from " . $this->tableName . " WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    //getting data for grid edit form 
    public function getEditItem($id, $type){
        $user = Session::get("user");
        $columns = [];
        foreach($this->editCategories[$type] as $key=>$value)
            $columns[] = $key;

        $result = DB::select("SELECT " . implode(",", $columns) . " from " . $this->tableName . " WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND " . $this->idField . "='" . $id ."'", array());

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

        $result = mysqli_query($this->db, "SELECT " . implode(",", $this->gridFields) . " from " . $this->tableName . " WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND " . $this->idField . "='" . $id ."'")  or die('mysql query error: ' . mysqli_error($this->db));

        $ret = mysqli_fetch_assoc($result);
        mysqli_free_result($result);
        
        return $ret;        
    }

    //updating data of grid item
    public function updateItem($id, $category, $values){
        $user = Session::get("user");
        
        $update_fields = "";
        foreach($this->editCategories[$category] as $name=>$value){
            if($update_fields == "")
                $update_fields = $name . "='" . $values[$name] . "'";
            else
                $update_fields .= "," . $name . "='" . $values[$name] . "'";
        }

        mysqli_query($this->db, "UPDATE " . $this->tableName . " set " . $update_fields . " WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND " . $this->idField . "='" . $id ."'")  or die('mysql query error: ' . mysqli_error($this->db));
    }

    //add row to table
    public function insertItem($values){
        $user = Session("user");
        
        $insert_fields = "";
        $insert_values = "";
        foreach($this->editCategories as $category=>$arr){
            foreach($this->editCategories[$category] as $name=>$value){
                if($insert_fields == ""){
                    $insert_fields = $name;
                    $insert_values = "'" . $values[$name] . "'";
                }else{
                    $insert_fields .= "," . $name;
                    $insert_values .= ",'" . $values[$name] . "'";
                }
            }
        }

        $insert_fields .= ',CompanyID,DivisionID,DepartmentID';
        $insert_values .= ",'" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "'";
        mysqli_query($this->db, "INSERT INTO " . $this->tableName . "(" . $insert_fields . ") values(" . $insert_values .")")  or die('mysql query error: ' . mysqli_error($this->db));
    }

    //delete row from table
    public function deleteItem($id){
        $user = Session::get("user");
        
        $update_fields = "";
        foreach($this->editCategories[$category] as $name=>$value){
            if($update_fields == "")
                $update_fields = $name . "='" . $values[$name] . "'";
            else
                $update_fields .= "," . $name . "='" . $values[$name] . "'";
        }

        mysqli_query($this->db, "DELETE from " . $this->tableName . " WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND " . $this->idField . "='" . $id ."'")  or die('mysql query error: ' . mysqli_error($this->db));
    }
}

?>