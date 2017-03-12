<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendoritemcrossreference";
protected $gridFields =["VendorID","VendorItemID","VendorItemDescription","ItemID","ItemDescription"];
public $dashboardTitle ="Vendor Item Cross Reference";
public $breadCrumbTitle ="Vendor Item Cross Reference";
public $idField ="VendorID";
public $editCategories = [
"Main" => [

"VendorID" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorItemDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemDescription" => [
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
