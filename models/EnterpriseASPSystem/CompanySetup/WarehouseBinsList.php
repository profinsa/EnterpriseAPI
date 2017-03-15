<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehousebins";
public $gridFields =["WarehouseID","WarehouseBinID","WarehouseBinName","WarehouseBinNumber","ResponsiblePerson"];
public $dashboardTitle ="WarehouseBins";
public $breadCrumbTitle ="WarehouseBins";
public $idField ="WarehouseID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WarehouseID","WarehouseBinID"];
public $editCategories = [
"Main" => [

"WarehouseID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinName" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinZone" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinType" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLocation" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLocationX" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLocationY" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLocationZ" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLength" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinWidth" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinHeight" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinWeight" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinRFID" => [
"inputType" => "text",
"defaultValue" => ""
],
"MinimumQuantity" => [
"inputType" => "text",
"defaultValue" => ""
],
"MaximumQuantity" => [
"inputType" => "text",
"defaultValue" => ""
],
"OverFlowBin" => [
"inputType" => "text",
"defaultValue" => ""
],
"LockerStock" => [
"inputType" => "text",
"defaultValue" => ""
],
"LockerStockQty" => [
"inputType" => "text",
"defaultValue" => ""
],
"ResponsiblePerson" => [
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
