<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "ediinvoicedetail";
public $dashboardTitle ="ediinvoicedetail";
public $breadCrumbTitle ="ediinvoicedetail";
public $idField ="";
public $idFields = [];
public $gridFields = [
"InvoiceNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceLineNumber" => [
"dbType" => "bigint(20)",
"inputType" => "text",
"defaultValue" => ""
],
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
"SerialNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"OrderQty" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"BackOrdered" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"BackOrderQty" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"ItemUOM" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemWeight" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"Description" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"DiscountPerc" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"Taxable" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
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
"ItemCost" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemUnitPrice" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Total" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"TotalWeight" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLSalesAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TrackingNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DetailMemo1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DetailMemo2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DetailMemo3" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DetailMemo4" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DetailMemo5" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxGroupID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxPercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"SubTotal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
]
];

public $editCategories = [
 "Main" => [
"InvoiceNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceLineNumber" => [
"dbType" => "bigint(20)",
"inputType" => "text",
"defaultValue" => ""
],
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
"SerialNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"OrderQty" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"BackOrdered" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"BackOrderQty" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"ItemUOM" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemWeight" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"Description" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"DiscountPerc" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"Taxable" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
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
"ItemCost" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemUnitPrice" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Total" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"TotalWeight" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLSalesAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TrackingNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DetailMemo1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DetailMemo2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DetailMemo3" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DetailMemo4" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DetailMemo5" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxGroupID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxPercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"SubTotal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
]]
];
public $columnNames = [
"InvoiceNumber" => "InvoiceNumber",
"InvoiceLineNumber" => "InvoiceLineNumber",
"ItemID" => "ItemID",
"WarehouseID" => "WarehouseID",
"SerialNumber" => "SerialNumber",
"OrderQty" => "OrderQty",
"BackOrdered" => "BackOrdered",
"BackOrderQty" => "BackOrderQty",
"ItemUOM" => "ItemUOM",
"ItemWeight" => "ItemWeight",
"Description" => "Description",
"DiscountPerc" => "DiscountPerc",
"Taxable" => "Taxable",
"CurrencyID" => "CurrencyID",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"ItemCost" => "ItemCost",
"ItemUnitPrice" => "ItemUnitPrice",
"Total" => "Total",
"TotalWeight" => "TotalWeight",
"GLSalesAccount" => "GLSalesAccount",
"ProjectID" => "ProjectID",
"TrackingNumber" => "TrackingNumber",
"DetailMemo1" => "DetailMemo1",
"DetailMemo2" => "DetailMemo2",
"DetailMemo3" => "DetailMemo3",
"DetailMemo4" => "DetailMemo4",
"DetailMemo5" => "DetailMemo5",
"TaxGroupID" => "TaxGroupID",
"TaxAmount" => "TaxAmount",
"TaxPercent" => "TaxPercent",
"SubTotal" => "SubTotal"];
}?>
