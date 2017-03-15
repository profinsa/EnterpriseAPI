<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendoritemcrossreference";
public $dashboardTitle ="Vendor Item Cross Reference";
public $breadCrumbTitle ="Vendor Item Cross Reference";
public $idField ="VendorID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID","VendorItemID"];
public $gridFields = [

"VendorID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"VendorItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"VendorItemDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ItemDescription" => [
    "dbType" => "varchar(80)",
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
"VendorItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"VendorItemDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"VendorID" => "Vendor ID",
"VendorItemID" => "Vendor Item ID",
"VendorItemDescription" => "Vendor Item Description",
"ItemID" => "Item ID",
"ItemDescription" => "Item Description"];
}?>
