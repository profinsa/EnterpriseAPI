<?php
/*
Name of Page: chartsOfAccount model

Method: 

Date created: Nikita Zaharov, 13.02.2016

Use:

Input parameters:
$db: database instance

Output parameters:


Called from:


Calls:
sql

Last Modified: 13.02.2016
Last Modified by: Nikita Zaharov
*/

class chartsOfAccount{
    protected $db = false;
    protected $gridFields = [
            "GLAccountNumber",
            "GLAccountName",
            "GLAccountType",
            "GLBalanceType",
            "GLAccountBalance",
    ];
    
    public $editCategories = [
        "Main" => [
            "GLAccountNumber",
            "GLAccountName",
            "GLAccountDescription",
            "GLAccountUse",
            "GLAccountType",
            "GLAccountCode",
            "GLBalanceType",
            "GLAccountBalance",
            "GLOtherNotes"	
        ],
        "Current" => [
            "GLCurrentYearPeriod1",	 
            "GLCurrentYearPeriod2",
            "GLCurrentYearPeriod3",	 
            "GLCurrentYearPeriod4",	 
            "GLCurrentYearPeriod5",	 
            "GLCurrentYearPeriod6",	 
            "GLCurrentYearPeriod7",	 
            "GLCurrentYearPeriod8",	 
            "GLCurrentYearPeriod9",	 
            "GLCurrentYearPeriod10",
            "GLCurrentYearPeriod11",
            "GLCurrentYearPeriod12",
            "GLCurrentYearPeriod13",
            "GLCurrentYearPeriod14"
        ],
        "Budget" => [
            "GLBudgetBeginningBalance",
            "GLBudgetPeriod1",
            "GLBudgetPeriod2",
            "GLBudgetPeriod3",
            "GLBudgetPeriod4",
            "GLBudgetPeriod5",
            "GLBudgetPeriod6",
            "GLBudgetPeriod7",
            "GLBudgetPeriod8",
            "GLBudgetPeriod9",
            "GLBudgetPeriod10",
            "GLBudgetPeriod11",
            "GLBudgetPeriod12",
            "GLBudgetPeriod13",
            "GLBudgetPeriod14"
        ],
        "History" => [
            "GLPriorYearBeginningBalance",
            "GLPriorYearPeriod1",
            "GLPriorYearPeriod2",
            "GLPriorYearPeriod3",
            "GLPriorYearPeriod4",	 
            "GLPriortYearPeriod5", //ERROR in sql, musql be Prior	 
            "GLPriorYearPeriod6",	 
            "GLPriorYearPeriod7",	 
            "GLPriorYearPeriod8",	 
            "GLPriorYearPeriod9",	 
            "GLPriortYearPeriod10",//ERROR in sql, musql be Prior	 
            "GLPriorYearPeriod11",
            "GLPriorYearPeriod12",
            "GLPriorYearPeriod13",
            "GLPriorYearPeriod14"
        ]
    ];

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

    public function getGLAccountTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = mysqli_query($this->db, "SELECT GLAccountType from ledgeraccounttypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'")  or die('mysql query error: ' . mysqli_error($this->db));

        while($ret = mysqli_fetch_assoc($result))
            $res[] = $ret;
        mysqli_free_result($result);
        
        return $res;
    }
    
    public function getGLBalanceTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = mysqli_query($this->db, "SELECT GLBalanceType from ledgerbalancetype WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'")  or die('mysql query error: ' . mysqli_error($this->db));

        while($ret = mysqli_fetch_assoc($result))
            $res[] = $ret;
        mysqli_free_result($result);
        
        return $res;
    }
    
    public function getPage($number){
        $user = $_SESSION["user"];
        $res = [];
        $result = mysqli_query($this->db, "SELECT " . implode(",", $this->gridFields) . " from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'")  or die('mysql query error: ' . mysqli_error($this->db));

        while($ret = mysqli_fetch_assoc($result))
            $res[] = $ret;
        mysqli_free_result($result);
        
        return $res;
    }

    public function getEditItem($GLAccountNumber, $type){
        $user = $_SESSION["user"];

        $result = mysqli_query($this->db, "SELECT " . implode(",", $this->editCategories[$type]) . " from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLAccountNumber='" . $GLAccountNumber ."'")  or die('mysql query error: ' . mysqli_error($this->db));

        $ret = mysqli_fetch_assoc($result);
        mysqli_free_result($result);
        
        return $ret;        
    }
    
    public function getItem($GLAccountNumber){
        $user = $_SESSION["user"];

        $result = mysqli_query($this->db, "SELECT " . implode(",", $this->gridFields) . " from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLAccountNumber='" . $GLAccountNumber ."'")  or die('mysql query error: ' . mysqli_error($this->db));

        $ret = mysqli_fetch_assoc($result);
        mysqli_free_result($result);
        
        return $ret;        
    }

    public function updateItem($GLAccountNumber, $category, $values){
        $user = $_SESSION["user"];
        
        $update_fields = "";
        foreach($this->editCategories[$category] as $name){
            if($update_fields == "")
                $update_fields = $name . "='" . $values[$name] . "'";
            else
                $update_fields .= "," . $name . "='" . $values[$name] . "'";
        }

        mysqli_query($this->db, "UPDATE ledgerchartofaccounts set " . $update_fields . " WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLAccountNumber='" . $GLAccountNumber ."'")  or die('mysql query error: ' . mysqli_error($this->db));
    }

    public function delete($GLAccountNumber){
    }
}
?>