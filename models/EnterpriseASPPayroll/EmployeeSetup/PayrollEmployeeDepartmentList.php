<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeedepartment";
protected $gridFields =["EmployeeDepartmentID","EmployeeDepartmentDescription"];
public $dashboardTitle ="PayrollEmployeeDepartment";
public $breadCrumbTitle ="PayrollEmployeeDepartment";
public $idField ="EmployeeDepartmentID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeDepartmentID"];
public $editCategories = [
"Main" => [

"EmployeeDepartmentID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeDepartmentDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeDepartmentID" => "Employee Department ID",
"EmployeeDepartmentDescription" => "Employee Department Description"];
}?>
