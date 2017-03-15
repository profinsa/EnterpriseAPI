<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestaskpriority";
public $gridFields =["PriorityID","PriorityDescription"];
public $dashboardTitle ="PayrollEmployeesTaskPriority";
public $breadCrumbTitle ="PayrollEmployeesTaskPriority";
public $idField ="PriorityID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PriorityID"];
public $editCategories = [
"Main" => [

"PriorityID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PriorityDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PriorityID" => "Priority ID",
"PriorityDescription" => "Priority Description"];
}?>
