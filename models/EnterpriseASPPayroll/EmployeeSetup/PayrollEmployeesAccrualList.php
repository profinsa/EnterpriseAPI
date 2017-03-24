<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeesaccrual";
public $dashboardTitle ="PayrollEmployeesAccrual";
public $breadCrumbTitle ="PayrollEmployeesAccrual";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","AccrualID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AmountAccrued" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"AmountUsed" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"LastAccrued" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AmountAccrued" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"AmountUsed" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"LastAccrued" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Active" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"AccrualID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"AmountAccrued" => "Amount Accrued",
"AmountUsed" => "Amount Used",
"LastAccrued" => "Last Accrued",
"Active" => "Active",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"AccrualID" => "AccrualID"];
}?>
