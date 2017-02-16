<?php
/*
Name of Page: chartOfAccounts model

Method: Model for GeneralLedger/chartOfAccounts. It provides data from database and default values, column names and categories

Date created: Nikita Zaharov, 13.02.2016

Use: this model used by views/GeneralLedger/chartOfAccounts.php for:
- as dictionary for view during building interface(tabs and them names, fields and them names etc, column name and translationid corresponding)
- for loading data from tables, updating, inserting and deleting

Input parameters:
$db: database instance
methods has own parameters

Output parameters:
- dictionaries as public properties
- methods has own output

Called from:
created and used for ajax requests by controllers/GeneralLedger/chartOfAccounts.php
used as model by views/GeneralLedger/chartOfAccounts.php

Calls:
sql

Last Modified: 16.02.2016
Last Modified by: Nikita Zaharov
*/

class chartOfAccounts{
    protected $db = false;
    //fields to render in grid
    protected $gridFields = [
            "GLAccountNumber",
            "GLAccountName",
            "GLAccountType",
            "GLBalanceType",
            "GLAccountBalance",
    ];

    //categories which contains table columns, used by view for render tabs and them content
    public $editCategories = [
        "Main" => [
            "GLAccountNumber" => "",
            "GLAccountName" => "",
            "GLAccountDescription" => "",
            "GLAccountUse" => "",
            "GLAccountType" => "",
            "GLAccountCode" => "",
            "GLBalanceType" => "",
            "GLAccountBalance" => "",
            "GLOtherNotes" => ""	
        ],
        "Current" => [
            "GLCurrentYearPeriod1" => "0.00",	 
            "GLCurrentYearPeriod2" => "0.00",
            "GLCurrentYearPeriod3" => "0.00",	 
            "GLCurrentYearPeriod4" => "0.00",	 
            "GLCurrentYearPeriod5" => "0.00",	 
            "GLCurrentYearPeriod6" => "0.00",	 
            "GLCurrentYearPeriod7" => "0.00",	 
            "GLCurrentYearPeriod8" => "0.00",	 
            "GLCurrentYearPeriod9" => "0.00",	 
            "GLCurrentYearPeriod10" => "0.00",
            "GLCurrentYearPeriod11" => "0.00",
            "GLCurrentYearPeriod12" => "0.00",
            "GLCurrentYearPeriod13" => "0.00",
            "GLCurrentYearPeriod14" => "0.00"
        ],
        "Budget" => [
            "GLBudgetBeginningBalance" => "0.00",
            "GLBudgetPeriod1" => "0.00",
            "GLBudgetPeriod2" => "0.00",
            "GLBudgetPeriod3" => "0.00",
            "GLBudgetPeriod4" => "0.00",
            "GLBudgetPeriod5" => "0.00",
            "GLBudgetPeriod6" => "0.00",
            "GLBudgetPeriod7" => "0.00",
            "GLBudgetPeriod8" => "0.00",
            "GLBudgetPeriod9" => "0.00",
            "GLBudgetPeriod10" => "0.00",
            "GLBudgetPeriod11" => "0.00",
            "GLBudgetPeriod12" => "0.00",
            "GLBudgetPeriod13" => "0.00",
            "GLBudgetPeriod14" => "0.00"
        ],
        "History" => [
            "GLPriorYearBeginningBalance" => "0.00",
            "GLPriorYearPeriod1" => "0.00",
            "GLPriorYearPeriod2" => "0.00",
            "GLPriorYearPeriod3" => "0.00",
            "GLPriorYearPeriod4" => "0.00",	 
            "GLPriortYearPeriod5" => "0.00", //ERROR in sql, must be Prior	 
            "GLPriorYearPeriod6" => "0.00",	 
            "GLPriorYearPeriod7" => "0.00",	 
            "GLPriorYearPeriod8" => "0.00",	 
            "GLPriorYearPeriod9" => "0.00",	 
            "GLPriortYearPeriod10" => "0.00",//ERROR in sql, must be Prior	 
            "GLPriorYearPeriod11" => "0.00",
            "GLPriorYearPeriod12" => "0.00",
            "GLPriorYearPeriod13" => "0.00",
            "GLPriorYearPeriod14" => "0.00"
        ]
    ];

    //table column to translation/ObjID
    public $columnNames = [
        "GLAccountNumber" => "Account Number",
        "GLAccountName" => "Account Name",
        "GLAccountDescription" => "Account Description",
        "GLAccountUse" => "Account Use",
        "GLAccountType" => "Account Type",
        "GLAccountCode" => "Account Code",
        "GLBalanceType" => "Balance Type",
        "GLAccountBalance" => "Account Balance",
        "GLOtherNotes" => "Other Notes",
        "GLCurrentYearPeriod1" => "GL Current Year Period 1",	 
        "GLCurrentYearPeriod2" => "GL Current Year Period 2",
        "GLCurrentYearPeriod3" => "GL Current Year Period 3",	 
        "GLCurrentYearPeriod4" => "GL Current Year Period 4",	 
        "GLCurrentYearPeriod5" => "GL Current Year Period 5",	 
        "GLCurrentYearPeriod6" => "GL Current Year Period 6",	 
        "GLCurrentYearPeriod7" => "GL Current Year Period 7",	 
        "GLCurrentYearPeriod8" => "GL Current Year Period 8",	 
        "GLCurrentYearPeriod9" => "GL Current Year Period 9",	 
        "GLCurrentYearPeriod10" => "GL Current Year Period 10",
        "GLCurrentYearPeriod11" => "GL Current Year Period 11",
        "GLCurrentYearPeriod12" => "GL Current Year Period 12",
        "GLCurrentYearPeriod13" => "GL Current Year Period 13",
        "GLCurrentYearPeriod14" => "GL Current Year Period 14",
        "GLBudgetBeginningBalance" => "GL Budget Beginning Balance",
        "GLBudgetPeriod1" => "GL Budget Period 1",
        "GLBudgetPeriod2" => "GL Budget Period 2",
        "GLBudgetPeriod3" => "GL Budget Period 3",
        "GLBudgetPeriod4" => "GL Budget Period 4",
        "GLBudgetPeriod5" => "GL Budget Period 5",
        "GLBudgetPeriod6" => "GL Budget Period 6",
        "GLBudgetPeriod7" => "GL Budget Period 7",
        "GLBudgetPeriod8" => "GL Budget Period 8",
        "GLBudgetPeriod9" => "GL Budget Period 9",
        "GLBudgetPeriod10" => "GL Budget Period 10",
        "GLBudgetPeriod11" => "GL Budget Period 11",
        "GLBudgetPeriod12" => "GL Budget Period 12",
        "GLBudgetPeriod13" => "GL Budget Period 13",
        "GLBudgetPeriod14" => "GL Budget Period 14",
        "GLPriorYearBeginningBalance" => "GL Prior Year Beginning Balance",
        "GLPriorYearPeriod1" => "GL Prior Year Period 1",
        "GLPriorYearPeriod2" => "GL Prior Year Period 2",
        "GLPriorYearPeriod3" => "GL Prior Year Period 3",
        "GLPriorYearPeriod4" => "GL Prior Year Period 4",	 
        "GLPriortYearPeriod5" => "GL Prior Year Period 5", //ERROR in sql, musql be Prior	 
        "GLPriorYearPeriod6" => "GL Prior Year Period 6",	 
        "GLPriorYearPeriod7" => "GL Prior Year Period 7",	 
        "GLPriorYearPeriod8" => "GL Prior Year Period 8",	 
        "GLPriorYearPeriod9" => "GL Prior Year Period 9",	 
        "GLPriortYearPeriod10" => "GL Prior Year Period 10",//ERROR in sql, musql be Prior	 
        "GLPriorYearPeriod11" => "GL Prior Year Period 11",
        "GLPriorYearPeriod12" => "GL Prior Year Period 12",
        "GLPriorYearPeriod13" => "GL Prior Year Period 13",
        "GLPriorYearPeriod14" => "GL Prior Year Period 14"
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
    
    //getting list of available values for GLBalanceType 
    public function getGLBalanceTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = mysqli_query($this->db, "SELECT GLBalanceType from ledgerbalancetype WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'")  or die('mysql query error: ' . mysqli_error($this->db));

        while($ret = mysqli_fetch_assoc($result))
            $res[] = $ret;
        mysqli_free_result($result);
        
        return $res;
    }

    //getting rows for grid
    public function getPage($number){
        $user = $_SESSION["user"];
        $res = [];
        $result = mysqli_query($this->db, "SELECT " . implode(",", $this->gridFields) . " from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'")  or die('mysql query error: ' . mysqli_error($this->db));

        while($ret = mysqli_fetch_assoc($result))
            $res[] = $ret;
        mysqli_free_result($result);
        
        return $res;
    }

    //getting data for grid edit form 
    public function getEditItem($GLAccountNumber, $type){
        $user = $_SESSION["user"];
        $columns = [];
        foreach($this->editCategories[$type] as $key=>$value)
            $columns[] = $key;

        $result = mysqli_query($this->db, "SELECT " . implode(",", $columns) . " from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLAccountNumber='" . $GLAccountNumber ."'")  or die('mysql query error: ' . mysqli_error($this->db));

        $ret = mysqli_fetch_assoc($result);
        mysqli_free_result($result);
        
        return $ret;        
    }

    //getting data for new record
    public function getNewItem($id, $type){
        if(key_exists("GLchartOfAccountsNew", $_SESSION))
            return $_SESSION["GLchartOfAccountsNew"]["$type"];
        else{
            $_SESSION["GLchartOfAccountsNew"] = $this->editCategories;
            return $this->editCategories[$type];           
        }
    } 

    //getting data for grid view form
    public function getItem($GLAccountNumber){
        $user = $_SESSION["user"];

        $result = mysqli_query($this->db, "SELECT " . implode(",", $this->gridFields) . " from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLAccountNumber='" . $GLAccountNumber ."'")  or die('mysql query error: ' . mysqli_error($this->db));

        $ret = mysqli_fetch_assoc($result);
        mysqli_free_result($result);
        
        return $ret;        
    }

    //updating data of grid item
    public function updateItem($GLAccountNumber, $category, $values){
        $user = $_SESSION["user"];
        
        $update_fields = "";
        foreach($this->editCategories[$category] as $name=>$value){
            if($update_fields == "")
                $update_fields = $name . "='" . $values[$name] . "'";
            else
                $update_fields .= "," . $name . "='" . $values[$name] . "'";
        }

        mysqli_query($this->db, "UPDATE ledgerchartofaccounts set " . $update_fields . " WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLAccountNumber='" . $GLAccountNumber ."'")  or die('mysql query error: ' . mysqli_error($this->db));
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
                    $insert_values .= ",'" . $value[$name] . "'";
                }
            }
        }

        $insert_fields .= ',CompanyID,DivisionID,DepartmentID';
        $insert_values .= ",'" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "'";
        mysqli_query($this->db, "INSERT INTO ledgerchartofaccounts(" . $insert_fields . ") values(" . $insert_values .")")  or die('mysql query error: ' . mysqli_error($this->db));
    }

    //delete row from table
    public function deleteItem($GLAccountNumber){
        $user = $_SESSION["user"];
        
        $update_fields = "";
        foreach($this->editCategories[$category] as $name=>$value){
            if($update_fields == "")
                $update_fields = $name . "='" . $values[$name] . "'";
            else
                $update_fields .= "," . $name . "='" . $values[$name] . "'";
        }

        mysqli_query($this->db, "DELETE from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLAccountNumber='" . $GLAccountNumber ."'")  or die('mysql query error: ' . mysqli_error($this->db));
    }
}
?>