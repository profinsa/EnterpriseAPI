<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "workorderpriority";
public $dashboardTitle ="Work Order Priorities";
public $breadCrumbTitle ="Work Order Priorities";
public $idField ="WorkOrderPriority";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderPriority"];
public $gridFields = [

"WorkOrderPriority" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WorkOrderPriorityDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WorkOrderPriority" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderPriorityDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkOrderPriority" => "Work Order Priority",
"WorkOrderPriorityDescription" => "Work Order Priority Description"];
}?>
