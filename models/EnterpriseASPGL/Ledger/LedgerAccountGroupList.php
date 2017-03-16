<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgeraccountgroup";
public $dashboardTitle ="Ledger Account Group";
public $breadCrumbTitle ="Ledger Account Group";
public $idField ="GLAccountGroupID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","GLAccountGroupID"];
public $gridFields = [

"GLAccountGroupID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLAccountGroupName" => [
    "dbType" => "varchar(128)",
    "inputType" => "text"
],
"GLAccountGroupBalance" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"GLAccountUse" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLReportingAccount" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
],
"GLReportLevel" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"GLAccountGroupID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountGroupName" => [
"dbType" => "varchar(128)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountGroupBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountUse" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLReportingAccount" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLReportLevel" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"GLAccountGroupID" => "Group Account ID",
"GLAccountGroupName" => "Group Account Name",
"GLAccountGroupBalance" => "Group Balance",
"GLAccountUse" => "Group Account Use",
"GLReportingAccount" => "Group Reporting Accounting",
"GLReportLevel" => "Group Reporting Level",
"GLAccountType" => "GLAccountType"];
}?>
