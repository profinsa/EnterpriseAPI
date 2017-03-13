<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "workorderinprogress";
protected $gridFields =["WorkOrderInProgress","WorkOrderInProgressDescription"];
public $dashboardTitle ="Work Order In Progress Types";
public $breadCrumbTitle ="Work Order In Progress Types";
public $idField ="WorkOrderInProgress";
public $editCategories = [
"Main" => [

"WorkOrderInProgress" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderInProgressDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkOrderInProgress" => "In Progress Type",
"WorkOrderInProgressDescription" => "In Progress Description"];
}?>