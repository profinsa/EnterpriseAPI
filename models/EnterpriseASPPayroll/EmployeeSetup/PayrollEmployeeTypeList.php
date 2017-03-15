<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeetype";
public $dashboardTitle ="PayrollEmployeeType";
public $breadCrumbTitle ="PayrollEmployeeType";
public $idField ="EmployeeTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeTypeID"];
public $gridFields = [

"EmployeeTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeTypeID" => "Employee Type ID",
"EmployeeTypeDescription" => "Employee Type Description"];
}?>
