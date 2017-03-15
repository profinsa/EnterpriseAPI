<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "workorderinprogress";
public $dashboardTitle ="Work Order In Progress Types";
public $breadCrumbTitle ="Work Order In Progress Types";
public $idField ="WorkOrderInProgress";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderInProgress"];
public $gridFields = [

"WorkOrderInProgress" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WorkOrderInProgressDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WorkOrderInProgress" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderInProgressDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkOrderInProgress" => "In Progress Type",
"WorkOrderInProgressDescription" => "In Progress Description"];
}?>
