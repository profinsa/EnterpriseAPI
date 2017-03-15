<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "workorderstatus";
protected $gridFields =["WorkOrderStatus","WorkOrderStatusDescription"];
public $dashboardTitle ="WorkOrderStatus";
public $breadCrumbTitle ="WorkOrderStatus";
public $idField ="WorkOrderStatus";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderStatus"];
public $editCategories = [
"Main" => [

"WorkOrderStatus" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderStatusDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkOrderStatus" => "Status",
"WorkOrderStatusDescription" => "Status Description"];
}?>
