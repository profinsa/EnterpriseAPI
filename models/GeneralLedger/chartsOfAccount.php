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
    protected $fields = [
        "main" => [
            "GLAccountNumber",
            "GLAccountName",
            "GLAccountType",
            "GLBalanceType",
            "GLAccountBalance",
        ],
        "mainToEdit" => [
            "GLAccountNumber",
            "GLAccountName",
            "GLAccountDescription",
            "GLAccountUse",
            "GLAccountType",
            "GLAccountCode",
            "GLBalanceType",
            "GLAccountBalance",
            "GLOtherNotes"	
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
        "GLOtherNotes" => "Other Notes"
    ];

    public function __construct($database){
        $this->db = $database;
    }

    public function getPage($number){
        $user = $_SESSION["user"];
        $res = [];
        $result = mysqli_query($this->db, "SELECT " . implode(",", $this->fields["main"]) . " from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'")  or die('mysql query error: ' . mysqli_error($this->db));

        while($ret = mysqli_fetch_assoc($result))
            $res[] = $ret;
        mysqli_free_result($result);
        
        return $res;
    }

    public function getItem($GLAccountNumber){
        $user = $_SESSION["user"];
        $res = [];
        
        $result = mysqli_query($this->db, "SELECT * from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLAccountNumber='" . $GLAccountNumber ."'")  or die('mysql query error: ' . mysqli_error($this->db));

        while($ret = mysqli_fetch_assoc($result))
            $res[] = $ret;
        mysqli_free_result($result);
        
        return $res;        
    }

    public function update($GLAccountNumber){
    }

    public function delete($GLAccountNumber){
    }
}
?>