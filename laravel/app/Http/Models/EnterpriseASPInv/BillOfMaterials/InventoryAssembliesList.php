<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryassemblies";
public $dashboardTitle ="Inventory Assemblies";
public $breadCrumbTitle ="Inventory Assemblies";
public $idField ="AssemblyID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AssemblyID","ItemID"];
public $gridFields = [

"AssemblyID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"AssemblyID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"NumberOfItemsInAssembly" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"dbType" => "varchar(3)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"LaborCost" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
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
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApprivedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"dbType" => "varchar(36)",
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
