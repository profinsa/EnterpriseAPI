<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehousebins";
public $dashboardTitle ="WarehouseBins";
public $breadCrumbTitle ="WarehouseBins";
public $idField ="WarehouseID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WarehouseID","WarehouseBinID"];
public $gridFields = [

"WarehouseID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WarehouseBinID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WarehouseBinName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"WarehouseBinNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ResponsiblePerson" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WarehouseID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinZone" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLocation" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLocationX" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLocationY" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLocationZ" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLength" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinWidth" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinHeight" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinWeight" => [
"dbType" => "bigint(20)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinRFID" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"MinimumQuantity" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"MaximumQuantity" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"OverFlowBin" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"LockerStock" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"LockerStockQty" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"ResponsiblePerson" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WarehouseID" => "Warehouse ID",
"WarehouseBinID" => "Warehouse Bin ID",
"WarehouseBinName" => "Warehouse Bin Name",
"WarehouseBinNumber" => "Warehouse Bin Number",
"ResponsiblePerson" => "Responsible Person",
"WarehouseBinZone" => "WarehouseBinZone",
"WarehouseBinType" => "WarehouseBinType",
"WarehouseBinLocation" => "WarehouseBinLocation",
"WarehouseBinLocationX" => "WarehouseBinLocationX",
"WarehouseBinLocationY" => "WarehouseBinLocationY",
"WarehouseBinLocationZ" => "WarehouseBinLocationZ",
"WarehouseBinLength" => "WarehouseBinLength",
"WarehouseBinWidth" => "WarehouseBinWidth",
"WarehouseBinHeight" => "WarehouseBinHeight",
"WarehouseBinWeight" => "WarehouseBinWeight",
"WarehouseBinRFID" => "WarehouseBinRFID",
"MinimumQuantity" => "MinimumQuantity",
"MaximumQuantity" => "MaximumQuantity",
"OverFlowBin" => "OverFlowBin",
"LockerStock" => "LockerStock",
"LockerStockQty" => "LockerStockQty"];
}?>
