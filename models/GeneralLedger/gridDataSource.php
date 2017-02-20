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

Last Modified: 17.02.2016
Last Modified by: Nikita Zaharov
*/
class gridDataSource{
    protected $tableName = "";
    protected $db = false;
    //fields to render in grid
    protected $gridFields = [];

    public $idField = "";
    
    public function __construct($database){
        $this->db = $database;
    }

    //getting list of available values for GLAccountType 
    public function getCurrencyTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $raw_res = [];
        $result = mysqli_query($this->db, "SELECT CurrencyID,CurrencyType from currencytypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'")  or die('mysql query error: ' . mysqli_error($this->db));

        while($ret = mysqli_fetch_assoc($result))
            $raw_res[] = $ret;
        foreach($raw_res as $key=>$value)
            $res[$value["CurrencyID"]] = [
                "title" => $value["CurrencyID"] . ", " . $value["CurrencyType"],
                "value" => $value["CurrencyID"]
            ];
        mysqli_free_result($result);
        
        return $res;
    }
    
    //getting rows for grid
    public function getPage($number){
        $user = $_SESSION["user"];
        $res = [];
        $result = mysqli_query($this->db, "SELECT " . implode(",", $this->gridFields) . " from " . $this->tableName . " WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'")  or die('mysql query error: ' . mysqli_error($this->db));

        while($ret = mysqli_fetch_assoc($result))
            $res[] = $ret;
        mysqli_free_result($result);
        
        return $res;
    }

    //getting data for grid edit form 
    public function getEditItem($id, $type){
        $user = $_SESSION["user"];
        $columns = [];
        foreach($this->editCategories[$type] as $key=>$value)
            $columns[] = $key;

        $result = mysqli_query($this->db, "SELECT " . implode(",", $columns) . " from " . $this->tableName . " WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND " . $this->idField . "='" . $id ."'")  or die('mysql query error: ' . mysqli_error($this->db));

        $ret = mysqli_fetch_assoc($result);
        mysqli_free_result($result);
        
        return $ret;        
    }

    //getting data for new record
    public function getNewItem($id, $type){
        $values = [];
        if(key_exists("GLbankTransactionsNew", $_SESSION))
            foreach($_SESSION["GLbankTransactionsNew"]["$type"] as $key=>$value)
                $values[$key] = $value["defaultValue"];
        else{
            $_SESSION["GLbankTransactionsNew"] = $this->editCategories;
            $values = [];
            foreach($this->editCategories[$type] as $key=>$value)
                $values[$key] = $value["defaultValue"];
        }
        return $values;
    } 

    //getting data for grid view form
    public function getItem($id){
        $user = $_SESSION["user"];

        $result = mysqli_query($this->db, "SELECT " . implode(",", $this->gridFields) . " from " . $this->tableName . " WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND " . $this->idField . "='" . $id ."'")  or die('mysql query error: ' . mysqli_error($this->db));

        $ret = mysqli_fetch_assoc($result);
        mysqli_free_result($result);
        
        return $ret;        
    }

    //updating data of grid item
    public function updateItem($id, $category, $values){
        $user = $_SESSION["user"];
        
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
        $user = $_SESSION["user"];
        
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
        $user = $_SESSION["user"];
        
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