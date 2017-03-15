<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeescurrentlyon";
public $dashboardTitle ="PayrollEmployeesCurrentlyOn";
public $breadCrumbTitle ="PayrollEmployeesCurrentlyOn";
public $idField ="LoginDate";
public $idFields = ["CompanyID","DivisionID","DepartmentID","LoginDate","EmployeeID"];
public $gridFields = [

"LoginDate" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"Status" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeEmail" => [
    "dbType" => "varchar(60)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"LoginDate" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Status" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeEmail" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"LoginDate" => "Login Date",
"EmployeeID" => "Employee ID",
"Status" => "Status",
"EmployeeEmail" => "Employee Email"];
}?>
