<?php
/*
Name of Page: ledgerAccountGroup model

Method: Model for GeneralLedger/ledgerAccountGroup. It provides data from database and default values, column names and categories

Date created: Nikita Zaharov, 16.02.2016

Use: this model used by views/GeneralLedger/ledgerAccountGroup.php for:
- as dictionary for view during building interface(tabs and them names, fields and them names etc, column name and translationid corresponding)
- for loading data from tables, updating, inserting and deleting

Input parameters:
$db: database instance
methods has own parameters

Output parameters:
- dictionaries as public properties
- methods has own output

Called from:
created and used for ajax requests by controllers/GeneralLedger/ledgerAccountGroup.php
used as model by views/GeneralLedger/ledgerAccountGroup.php

Calls:
sql

Last Modified: 20.02.2016
Last Modified by: Nikita Zaharov
*/

require "./models/GeneralLedger/gridDataSource.php";

class ledgerAccountGroup extends gridDataSource{
    protected $tableName = "ledgeraccountgroup";

    //fields to render in grid
    protected $gridFields = [
        "GLAccountGroupID",
        "GLAccountGroupName",
        "GLAccountGroupBalance",
        "GLAccountUse",
        "GLReportingAccount",
        "GLReportLevel"
    ];

    public $idField = "GLAccountGroupID";
    
    //categories which contains table columns, used by view for render tabs and them content
    public $editCategories = [
        "Main" => [
            "GLAccountGroupID" => [
                "disabledEdit" => true,
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountGroupName" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountGroupBalance"	=> [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLAccountUse" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLReportingAccount" => [
                "inputType" => "text",
                "defaultValue" => "False"
            ],
            "GLReportLevel" => [
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];

    //table column to translation/ObjID
    public $columnNames = [
            "GLAccountGroupID" => "Group Account ID",
            "GLAccountGroupName" => "Group Account Name",
            "GLAccountGroupBalance"	=> "Group Balance",
            "GLAccountUse" => "Group Account Use",
            "GLReportingAccount" => "Group Reporting Accounting",
            "GLReportLevel" => "Group Reporting Level"
    ];

    public function __construct($database){
        $this->db = $database;
    }

    //getting rows for grid
    public function getPage($number){
        $user = $_SESSION["user"];
        $res = [];
        $result = mysqli_query($this->db, "SELECT " . implode(",", $this->gridFields) . " from ledgeraccountgroup WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'")  or die('mysql query error: ' . mysqli_error($this->db));

        while($ret = mysqli_fetch_assoc($result))
            $res[] = $ret;
        mysqli_free_result($result);
        
        return $res;
    }

    //getting data for grid edit form 
    public function getEditItem($GLAccountGroupID, $type){
        $user = $_SESSION["user"];
        $columns = [];
        foreach($this->editCategories[$type] as $key=>$value)
            $columns[] = $key;

        $result = mysqli_query($this->db, "SELECT " . implode(",", $columns) . " from ledgeraccountgroup WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLAccountGroupID='" . $GLAccountGroupID ."'")  or die('mysql query error: ' . mysqli_error($this->db));

        $ret = mysqli_fetch_assoc($result);
        mysqli_free_result($result);
        
        return $ret;        
    }

    //getting data for new record
    public function getNewItem($id, $type){
        if(key_exists("GLledgerAccountGroupNew", $_SESSION))
            return $_SESSION["GLledgerAccountGroupNew"]["$type"];
        else{
            $_SESSION["GLledgerAccountGroupNew"] = $this->editCategories;
            return $this->editCategories[$type];           
        }
    } 

    //getting data for grid view form
    public function getItem($GLAccountGroupID){
        $user = $_SESSION["user"];

        $result = mysqli_query($this->db, "SELECT " . implode(",", $this->gridFields) . " from ledgeraccountgroup WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLAccountGroupID='" . $GLAccountGroupID ."'")  or die('mysql query error: ' . mysqli_error($this->db));

        $ret = mysqli_fetch_assoc($result);
        mysqli_free_result($result);
        
        return $ret;        
    }

    //updating data of grid item
    public function updateItem($GLAccountGroupID, $category, $values){
        $user = $_SESSION["user"];
        
        $update_fields = "";
        foreach($this->editCategories[$category] as $name=>$value){
            if($update_fields == "")
                $update_fields = $name . "='" . $values[$name] . "'";
            else
                $update_fields .= "," . $name . "='" . $values[$name] . "'";
        }

        mysqli_query($this->db, "UPDATE ledgeraccountgroup set " . $update_fields . " WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLAccountGroupID='" . $GLAccountGroupID ."'")  or die('mysql query error: ' . mysqli_error($this->db));
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
        mysqli_query($this->db, "INSERT INTO ledgeraccountgroup(" . $insert_fields . ") values(" . $insert_values .")")  or die('mysql query error: ' . mysqli_error($this->db));
    }

    //delete row from table
    public function deleteItem($GLAccountGroupID){
        $user = $_SESSION["user"];
        
        $update_fields = "";
        foreach($this->editCategories[$category] as $name=>$value){
            if($update_fields == "")
                $update_fields = $name . "='" . $values[$name] . "'";
            else
                $update_fields .= "," . $name . "='" . $values[$name] . "'";
        }

        mysqli_query($this->db, "DELETE from ledgeraccountgroup WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLAccountGroupID='" . $GLAccountGroupID ."'")  or die('mysql query error: ' . mysqli_error($this->db));
    }
}
?>