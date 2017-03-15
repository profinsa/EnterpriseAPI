<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorybywarehouse";
public $dashboardTitle ="Inventory By Warehouse";
public $breadCrumbTitle ="Inventory By Warehouse";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","WarehouseID","WarehouseBinID"];
public $gridFields = [

"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WarehouseID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WarehouseBinID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"QtyOnHand" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"QtyCommitted" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"QtyOnOrder" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"QtyOnBackorder" => [
    "dbType" => "int(11)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ItemID" => [
"dbType" => "varchar(36)",
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
"QtyOnHand" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QtyCommitted" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QtyOnOrder" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QtyOnBackorder" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"CycleCode" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"LastCountDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"WarehouseID" => "Warehouse ID",
"WarehouseBinID" => "WarehouseBinID",
"QtyOnHand" => "Qty On Hand",
"QtyCommitted" => "Qty Committed",
"QtyOnOrder" => "Qty On Order",
"QtyOnBackorder" => "Qty On Backorder",
"CycleCode" => "CycleCode",
"LastCountDate" => "LastCountDate"];
}?>
