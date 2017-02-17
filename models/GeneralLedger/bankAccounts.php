<?php
/*
Name of Page: bankAccounts model

Method: Model for GeneralLedger/banckAccounts. It provides data from database and default values, column names and categories

Date created: Nikita Zaharov, 17.02.2016

Use: this model used by views/GeneralLedger/bankAccounts.php for:
- as dictionary for view during building interface(tabs and them names, fields and them names etc, column name and translationid corresponding)
- for loading data from tables, updating, inserting and deleting

Input parameters:
$db: database instance
methods has own parameters

Output parameters:
- dictionaries as public properties
- methods has own output

Called from:
created and used for ajax requests by controllers/GeneralLedger/banckAccounts.php
used as model by views/GeneralLedger/backAccounts.php

Calls:
sql

Last Modified: 17.02.2016
Last Modified by: Nikita Zaharov
*/

class bankAccounts{
    protected $tableName = "bankaccounts";
    protected $db = false;
    //fields to render in grid
    protected $gridFields = [
        "BankID",
        "BankAccountNumber",
        "BankName",
        "BankPhone",
        "GLBankAccount"
    ];

    public $idField = "BankAccountNumber";
    
    //categories which contains table columns, used by view for render tabs and them content
    public $editCategories = [
        "Main" => [
            "BankID" => "",
            "BankAccountNumber" => "",
            "BankName" => "",
            "BankAddress1" => "",
            "BankAddress2" => "",
            "BankCity" => "",
            "BankState" => "",
            "BankZip" => "",
            "BankCountry" => "",
            "BankPhone" => "",
            "BankFax" => "",
            "BankContactName" => "",
            "BankEmail" => "",
            "BankWebsite" => "",
            "SwiftCode" => "",
            "RoutingCode" => "",
            "CurrencyID" => "USD",
            "CurrencyExchangeRate" => "1.00",
            "NextCheckNumber" => "",
            "NextDepositNumber" => "",
            "UnpostedDeposits" => "0.00",
            "GLBankAccount" => "",
            "Notes" => ""
        ],
    ];

    //table column to translation/ObjID
    public $columnNames = [
        "BankID" => "Bank ID",
        "BankAccountNumber" => "Bank Account Number",
        "BankName" => "Bank Name",
        "BankAddress1" => "Bank Address 1",
        "BankAddress2" => "Bank Address 2",
        "BankCity" => "Bank City",
        "BankState" => "Bank State",
        "BankZip" => "Bank Zip",
        "BankCountry" => "Bank Country",
        "BankPhone" => "Bank Phone",
        "BankFax" => "Bank Fax",
        "BankContactName" => "Bank Contact Name",
        "BankEmail" => "Bank Email",
        "BankWebsite" => "Bank Website",
        "SwiftCode" => "Swift Code",
        "RoutingCode" => "Routing Code",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "NextCheckNumber" => "Next Check Number",
        "NextDepositNumber" => "Next Deposit Number",
        "UnpostedDeposits" => "Unposted Deposits",
        "GLBankAccount" => "GL Bank Account",
        "Notes" => "Notes"
    ];

    public function __construct($database){
        $this->db = $database;
    }

    //getting list of available values for GLAccountType 
    public function getGLAccountTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = mysqli_query($this->db, "SELECT GLAccountType from ledgeraccounttypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'")  or die('mysql query error: ' . mysqli_error($this->db));

        while($ret = mysqli_fetch_assoc($result))
            $res[] = $ret;
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
        if(key_exists("GLbankAccountsNew", $_SESSION))
            return $_SESSION["GLbankAccountsNew"]["$type"];
        else{
            $_SESSION["GLbankAccountsNew"] = $this->editCategories;
            return $this->editCategories[$type];           
        }
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