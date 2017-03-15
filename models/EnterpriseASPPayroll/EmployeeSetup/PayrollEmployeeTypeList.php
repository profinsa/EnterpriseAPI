<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeetype";
protected $gridFields =["EmployeeTypeID","EmployeeTypeDescription"];
public $dashboardTitle ="PayrollEmployeeType";
public $breadCrumbTitle ="PayrollEmployeeType";
public $idField ="EmployeeTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeTypeID"];
public $editCategories = [
"Main" => [

"EmployeeTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeTypeID" => "Employee Type ID",
"EmployeeTypeDescription" => "Employee Type Description"];
}?>
