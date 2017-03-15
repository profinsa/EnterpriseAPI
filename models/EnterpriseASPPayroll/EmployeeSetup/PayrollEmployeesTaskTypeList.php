<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestasktype";
protected $gridFields =["TaskTypeID","TaskTypeDescription"];
public $dashboardTitle ="PayrollEmployeesTaskType";
public $breadCrumbTitle ="PayrollEmployeesTaskType";
public $idField ="TaskTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TaskTypeID"];
public $editCategories = [
"Main" => [

"TaskTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkFlowTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaskTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaskTypeRule" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaskTypeManager" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"TaskTypeID" => "Task Type ID",
"TaskTypeDescription" => "Task Type Description",
"WorkFlowTypeID" => "WorkFlowTypeID",
"TaskTypeRule" => "TaskTypeRule",
"TaskTypeManager" => "TaskTypeManager"];
}?>
