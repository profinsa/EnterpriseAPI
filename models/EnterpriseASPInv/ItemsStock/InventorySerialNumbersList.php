<?php

/*
Name of Page: InventorySerialNumbersList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventorySerialNumbersList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventorySerialNumbersList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventorySerialNumbersList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventorySerialNumbersList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class InventorySerialNumbersList extends gridDataSource{
public $tableName = "inventoryserialnumbers";
public $dashboardTitle ="Inventory Serial Numbers";
public $breadCrumbTitle ="Inventory Serial Numbers";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","WarehouseID","WarehouseBinID","PurchaseOrderNumber","PurchaseOrderLineNumber","SerialNumber"];
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
"PurchaseOrderNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PurchaseOrderLineNumber" => [
    "dbType" => "decimal(18,0)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"SerialNumber" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"DateReceived" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"OriginalLotOrderQty" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"CurrentLotOrderQty" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"LotExpirationDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"ItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SerialNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseOrderNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseOrderLineNumber" => [
"dbType" => "decimal(18,0)",
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
"OrderNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"OrderLineNumber" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceLineNumber" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
],
"DateReceived" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"OriginalLotOrderQty" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrentLotOrderQty" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"LotExpirationDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"SerialNumberComment" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"WarehouseID" => "Warehouse ID",
"WarehouseBinID" => "Warehouse Bin ID",
"PurchaseOrderNumber" => "Purchase Order Number",
"PurchaseOrderLineNumber" => "Purchase Order Line Number",
"SerialNumber" => "Serial Number",
"DateReceived" => "Date Received",
"OriginalLotOrderQty" => "Original Lot Order Qty",
"CurrentLotOrderQty" => "Current Lot Order Qty",
"LotExpirationDate" => "Lot Expiration Date",
"OrderNumber" => "Order Number",
"OrderLineNumber" => "Order Line Number",
"InvoiceNumber" => "Invoice Number",
"InvoiceLineNumber" => "Invoice Line Number",
"SerialNumberComment" => "Serial Number Comment"];
}?>
