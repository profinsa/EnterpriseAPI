<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryserialnumbers";
protected $gridFields =["ItemID","WarehouseID","WarehouseBinID","PurchaseOrderNumber","PurchaseOrderLineNumber","SerialNumber","DateReceived","OriginalLotOrderQty","CurrentLotOrderQty","LotExpirationDate"];
public $dashboardTitle ="Inventory Serial Numbers";
public $breadCrumbTitle ="Inventory Serial Numbers";
public $idField ="ItemID";
public $editCategories = [
"Main" => [

"ItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"SerialNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseOrderNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseOrderLineNumber" => [
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
"OrderNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"OrderLineNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceLineNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"DateReceived" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"OriginalLotOrderQty" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrentLotOrderQty" => [
"inputType" => "text",
"defaultValue" => ""
],
"LotExpirationDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"SerialNumberComment" => [
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
