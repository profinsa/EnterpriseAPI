<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendorpricecrossreference";
protected $gridFields =["VendorID","ItemPricingCode","ItemPrice","Freight","Handling","Advertising","Shipping"];
public $dashboardTitle ="Vendor Price Cross Reference";
public $breadCrumbTitle ="Vendor Price Cross Reference";
public $idField ="VendorID";
public $editCategories = [
"Main" => [

"VendorID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemPricingCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemPrice" => [
"inputType" => "text",
"defaultValue" => ""
],
"Freight" => [
"inputType" => "text",
"defaultValue" => ""
],
"Handling" => [
"inputType" => "text",
"defaultValue" => ""
],
"Advertising" => [
"inputType" => "text",
"defaultValue" => ""
],
"Shipping" => [
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
