<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehousebinzones";
public $dashboardTitle ="WarehouseBinZones";
public $breadCrumbTitle ="WarehouseBinZones";
public $idField ="WarehouseBinZoneID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WarehouseBinZoneID"];
public $gridFields = [

"WarehouseBinZoneID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WarehouseBinZoneDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WarehouseBinZoneID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinZoneDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WarehouseBinZoneID" => "Warehouse Bin Zone ID",
"WarehouseBinZoneDescription" => "Warehouse Bin Zone Description"];
}?>
