<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeescurrentlyon";
protected $gridFields =["LoginDate","EmployeeID","Status","EmployeeEmail"];
public $dashboardTitle ="PayrollEmployeesCurrentlyOn";
public $breadCrumbTitle ="PayrollEmployeesCurrentlyOn";
public $idField ="LoginDate";
public $idFields = ["CompanyID","DivisionID","DepartmentID","LoginDate","EmployeeID"];
public $editCategories = [
"Main" => [

"LoginDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"Status" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeEmail" => [
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
