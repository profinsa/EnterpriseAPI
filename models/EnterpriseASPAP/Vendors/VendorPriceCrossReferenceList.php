<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendorpricecrossreference";
public $dashboardTitle ="Vendor Price Cross Reference";
public $breadCrumbTitle ="Vendor Price Cross Reference";
public $idField ="VendorID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID","ItemPricingCode"];
public $gridFields = [

"VendorID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ItemPricingCode" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ItemPrice" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"Freight" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"Handling" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"Advertising" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"Shipping" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"VendorID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemPricingCode" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemPrice" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Freight" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Handling" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Advertising" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Shipping" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"VendorID" => "Vendor ID",
"ItemPricingCode" => "Item Pricing Code",
"ItemPrice" => "Item Price",
"Freight" => "Freight",
"Handling" => "Handling",
"Advertising" => "Advertising",
"Shipping" => "Shipping",
"CurrencyID" => "CurrencyID"];
}?>
