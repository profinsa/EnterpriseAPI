<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryserialnumbers";
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
"OrderNumber" => "OrderNumber",
"OrderLineNumber" => "OrderLineNumber",
"InvoiceNumber" => "InvoiceNumber",
"InvoiceLineNumber" => "InvoiceLineNumber",
"SerialNumberComment" => "SerialNumberComment"];
}?>
