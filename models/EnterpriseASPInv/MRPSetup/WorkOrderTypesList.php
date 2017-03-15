<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "workordertypes";
protected $gridFields =["WorkOrderTypes","WorkOrderTypesDescription"];
public $dashboardTitle ="Work Order Types";
public $breadCrumbTitle ="Work Order Types";
public $idField ="WorkOrderTypes";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderTypes"];
public $editCategories = [
"Main" => [

"WorkOrderTypes" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderTypesDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkOrderTypes" => "Type",
"WorkOrderTypesDescription" => "Type Description"];
}?>
