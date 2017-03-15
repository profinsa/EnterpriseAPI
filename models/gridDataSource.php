<?php
/*
Name of Page: gridDataSource class

Method: ancestor for GeneralLedger/* models. It provides data from database

Date created: Nikita Zaharov, 17.02.2016

Use: this model used for
- for loading data from tables, updating, inserting and deleting

Input parameters:
$capsule: database instance
methods has own parameters

Output parameters:
- methods has own output

Called from:
inherited by models/GeneralLedger/*

Calls:
sql

Last Modified: 06.03.2016
Last Modified by: Nikita Zaharov
*/
class gridDataSource{
    protected $tableName = "";
    //fields to render in grid
    protected $gridFields = [];

    public $idField = "";
    
    //getting list of available transaction types 
    public function getAccounts(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT GLAccountNumber,GLAccountName from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->GLAccountNumber] = [
                "title" => $value->GLAccountNumber . ", " . $value->GLAccountName,
                "value" => $value->GLAccountNumber
            ];
        return $res;
    }
    
    //getting list of available values for GLAccountType 
    public function getCurrencyTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT CurrencyID,CurrencyType from currencytypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->CurrencyID] = [
                "title" => $value->CurrencyID . ", " . $value->CurrencyType,
                "value" => $value->CurrencyID
            ];
        
        return $res;
    }
    
    //getting rows for grid
    public function getPage($number){
        $user = $_SESSION["user"];
        $keyFields = "";
        $fields = [];
        foreach($this->gridFields as $value)
            $fields[] = $value;
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

        $result = $GLOBALS["capsule"]::select("SELECT " . implode(",", $fields) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    //getting data for grid edit form 
    public function getEditItem($id, $type){
        $user = $_SESSION["user"];
        $columns = [];
        foreach($this->editCategories[$type] as $key=>$value)
            $columns[] = $key;

        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = $GLOBALS["capsule"]::select("SELECT " . implode(",", $columns) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true)[0];
        
        return $result;        
    }

    //getting data for new record
    public function getNewItem($id, $type){
        $values = [];
        if(key_exists("GL" . $this->tableName . "New", $_SESSION))
            foreach($_SESSION["GL" . $this->tableName . "New"]["$type"] as $key=>$value)
                $values[$key] = $value["defaultValue"];
        else{
            $_SESSION["GL" . $this->tableName . "New"] = $this->editCategories;
            $values = [];
            foreach($this->editCategories[$type] as $key=>$value)
                $values[$key] = $value["defaultValue"];
        }
        return $values;
    } 

    //getting data for grid view form
    public function getItem($id){
        $user = $_SESSION["user"];
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);


        $result = $GLOBALS["capsule"]::select("SELECT " . implode(",", $this->gridFields) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        return json_decode(json_encode($result), true)[0];
    }

    //updating data of grid item
    public function updateItem($id, $category, $values){
        $user = $_SESSION["user"];
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        $update_fields = "";
        foreach($this->editCategories[$category] as $name=>$value){
            if($value["inputType"] == 'timestamp' || $value["inputType"] == 'datetime')
                $values[$name] = date("Y-m-d H:i:s", strtotime($values[$name]));
                                      
            if($update_fields == "")
                $update_fields = $name . "='" . $values[$name] . "'";
            else
                $update_fields .= "," . $name . "='" . $values[$name] . "'";
        }

        $GLOBALS["capsule"]::update("UPDATE " . $this->tableName . " set " . $update_fields .  ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }

    //add row to table
    public function insertItem($values){
        $user = $_SESSION["user"];
        
        $insert_fields = "";
        $insert_values = "";
        foreach($this->editCategories as $category=>$arr){
            foreach($this->editCategories[$category] as $name=>$value){
                if($value["inputType"] == 'timestamp' || $value["inputType"] == 'datetime')
                    $values[$name] = date("Y-m-d H:i:s", strtotime($values[$name]));
                                      
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
        $GLOBALS["capsule"]::insert("INSERT INTO " . $this->tableName . "(" . $insert_fields . ") values(" . $insert_values .")");
    }

    //delete row from table
    public function deleteItem($id){
        $user = $_SESSION["user"];
        
        $GLOBALS["capsule"]::delete("DELETE from " . $this->tableName . " WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND " . $this->idField . "='" . $id ."'");
    }
}
?>