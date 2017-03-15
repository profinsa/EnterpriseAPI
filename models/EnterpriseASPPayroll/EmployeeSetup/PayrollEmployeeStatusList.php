<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestatus";
protected $gridFields =["EmployeeStatusID","EmployeeStatusDescription"];
public $dashboardTitle ="PayrollEmployeeStatus";
public $breadCrumbTitle ="PayrollEmployeeStatus";
public $idField ="EmployeeStatusID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeStatusID"];
public $editCategories = [
"Main" => [

"EmployeeStatusID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeStatusDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeStatusID" => "Employee Status ID",
"EmployeeStatusDescription" => "Employee Status Description"];
}?>
