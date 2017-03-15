<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeepayfrequency";
public $dashboardTitle ="PayrollEmployeePayFrequency";
public $breadCrumbTitle ="PayrollEmployeePayFrequency";
public $idField ="EmployeePayFrequencyID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeePayFrequencyID"];
public $gridFields = [

"EmployeePayFrequencyID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeePayFrequencyDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeePayFrequencyID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePayFrequencyDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeePayFrequencyID" => "Employee Pay Frequency ID",
"EmployeePayFrequencyDescription" => "Employee Pay Frequency Description"];
}?>
