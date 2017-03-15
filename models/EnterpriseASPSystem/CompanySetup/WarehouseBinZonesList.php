<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehousebinzones";
public $gridFields =["WarehouseBinZoneID","WarehouseBinZoneDescription"];
public $dashboardTitle ="WarehouseBinZones";
public $breadCrumbTitle ="WarehouseBinZones";
public $idField ="WarehouseBinZoneID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WarehouseBinZoneID"];
public $editCategories = [
"Main" => [

"WarehouseBinZoneID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinZoneDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WarehouseBinZoneID" => "Warehouse Bin Zone ID",
"WarehouseBinZoneDescription" => "Warehouse Bin Zone Description"];
}?>
