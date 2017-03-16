<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollchecks";
public $dashboardTitle ="PayrollChecks";
public $breadCrumbTitle ="PayrollChecks";
public $idField ="PayrollID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PayrollID","EmployeeID"];
public $gridFields = [

"PayrollID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PayrollCheckDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"StartDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"EndDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"CheckNumber" => [
    "dbType" => "varchar(20)",
    "inputType" => "text"
],
"Amount" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PayrollID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollCheckDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"StartDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EndDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CheckPrinted" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Amount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLEmployeeCreditAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CheckNumber" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"CheckTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"dbType" => "varchar(3)",
"inputType" => "text",
"defaultValue" => ""
],
"Apply" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PayrollID" => "Payroll ID",
"EmployeeID" => "Employee ID",
"PayrollCheckDate" => "Payroll Check Date",
"StartDate" => "Pay Period Start Date",
"EndDate" => "Pay Period End Date",
"CheckNumber" => "Check Number",
"Amount" => "Amount",
"CheckPrinted" => "CheckPrinted",
"GLEmployeeCreditAccount" => "GLEmployeeCreditAccount",
"CheckTypeID" => "CheckTypeID",
"CurrencyID" => "CurrencyID",
"Apply" => "Apply"];
}?>