<?php

/*
Name of Page: InventoryByWarehouseList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryByWarehouseList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventoryByWarehouseList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryByWarehouseList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryByWarehouseList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "inventorybywarehouse";
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
"WarehouseBinID" => "Warehouse Bin ID",
"QtyOnHand" => "Qty On Hand",
"QtyCommitted" => "Qty Committed",
"QtyOnOrder" => "Qty On Order",
"QtyOnBackorder" => "Qty On Backorder",
"CycleCode" => "Cycle Code",
"LastCountDate" => "Last Count Date"];
}?>
