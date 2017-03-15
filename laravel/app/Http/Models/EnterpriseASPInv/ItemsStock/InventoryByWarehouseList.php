<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorybywarehouse";
public $gridFields =["ItemID","WarehouseID","WarehouseBinID","QtyOnHand","QtyCommitted","QtyOnOrder","QtyOnBackorder"];
public $dashboardTitle ="Inventory By Warehouse";
public $breadCrumbTitle ="Inventory By Warehouse";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","WarehouseID","WarehouseBinID"];
public $editCategories = [
"Main" => [

"ItemID" => [
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
"QtyOnHand" => [
"inputType" => "text",
"defaultValue" => ""
],
"QtyCommitted" => [
"inputType" => "text",
"defaultValue" => ""
],
"QtyOnOrder" => [
"inputType" => "text",
"defaultValue" => ""
],
"QtyOnBackorder" => [
"inputType" => "text",
"defaultValue" => ""
],
"CycleCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastCountDate" => [
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
