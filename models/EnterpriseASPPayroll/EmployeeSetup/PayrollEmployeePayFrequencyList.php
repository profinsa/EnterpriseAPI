<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeepayfrequency";
public $gridFields =["EmployeePayFrequencyID","EmployeePayFrequencyDescription"];
public $dashboardTitle ="PayrollEmployeePayFrequency";
public $breadCrumbTitle ="PayrollEmployeePayFrequency";
public $idField ="EmployeePayFrequencyID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeePayFrequencyID"];
public $editCategories = [
"Main" => [

"EmployeePayFrequencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePayFrequencyDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeePayFrequencyID" => "Employee Pay Frequency ID",
"EmployeePayFrequencyDescription" => "Employee Pay Frequency Description"];
}?>
