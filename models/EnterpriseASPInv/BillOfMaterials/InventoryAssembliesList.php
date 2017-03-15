<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryassemblies";
protected $gridFields =["AssemblyID"];
public $dashboardTitle ="Inventory Assemblies";
public $breadCrumbTitle ="Inventory Assemblies";
public $idField ="AssemblyID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AssemblyID","ItemID"];
public $editCategories = [
"Main" => [

"AssemblyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"NumberOfItemsInAssembly" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"LaborCost" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinID" => [
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprivedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AssemblyID" => "Assembly ID",
"ItemID" => "ItemID",
"NumberOfItemsInAssembly" => "NumberOfItemsInAssembly",
"CurrencyID" => "CurrencyID",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"LaborCost" => "LaborCost",
"WarehouseID" => "WarehouseID",
"WarehouseBinID" => "WarehouseBinID",
"Approved" => "Approved",
"ApprivedBy" => "ApprivedBy",
"ApprovedDate" => "ApprovedDate",
"EnteredBy" => "EnteredBy"];
}?>
