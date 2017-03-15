<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestaskpriority";
public $dashboardTitle ="PayrollEmployeesTaskPriority";
public $breadCrumbTitle ="PayrollEmployeesTaskPriority";
public $idField ="PriorityID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PriorityID"];
public $gridFields = [

"PriorityID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PriorityDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PriorityID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PriorityDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PriorityID" => "Priority ID",
"PriorityDescription" => "Priority Description"];
}?>
