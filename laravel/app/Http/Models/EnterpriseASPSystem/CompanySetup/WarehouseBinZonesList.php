<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehousebinzones";
protected $gridFields =["WarehouseBinZoneID","WarehouseBinZoneDescription"];
public $dashboardTitle ="WarehouseBinZones";
public $breadCrumbTitle ="WarehouseBinZones";
public $idField ="WarehouseBinZoneID";
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
