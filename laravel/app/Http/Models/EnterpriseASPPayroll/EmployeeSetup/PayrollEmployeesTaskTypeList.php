<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestasktype";
public $dashboardTitle ="PayrollEmployeesTaskType";
public $breadCrumbTitle ="PayrollEmployeesTaskType";
public $idField ="TaskTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TaskTypeID"];
public $gridFields = [

"TaskTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TaskTypeDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TaskTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkFlowTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaskTypeDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"TaskTypeRule" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"TaskTypeManager" => [
"dbType" => "varchar(36)",
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
