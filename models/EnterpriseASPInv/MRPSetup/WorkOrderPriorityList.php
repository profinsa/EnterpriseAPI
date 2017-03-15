<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "workorderpriority";
public $gridFields =["WorkOrderPriority","WorkOrderPriorityDescription"];
public $dashboardTitle ="Work Order Priorities";
public $breadCrumbTitle ="Work Order Priorities";
public $idField ="WorkOrderPriority";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderPriority"];
public $editCategories = [
"Main" => [

"WorkOrderPriority" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderPriorityDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkOrderPriority" => "Work Order Priority",
"WorkOrderPriorityDescription" => "Work Order Priority Description"];
}?>
