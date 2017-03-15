<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customerpricecrossreference";
public $gridFields =["CustomerID","ItemPricingCode","ItemPrice","Freight","Handling","Advertising","Shipping"];
public $dashboardTitle ="Customer Price Cross Reference";
public $breadCrumbTitle ="Customer Price Cross Reference";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ItemPricingCode"];
public $editCategories = [
"Main" => [

"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemPricingCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemPrice" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
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

"CustomerID" => "Customer ID",
"ItemPricingCode" => "Item Pricing Code",
"ItemPrice" => "Item Price",
"Freight" => "Freight",
"Handling" => "Handling",
"Advertising" => "Advertising",
"Shipping" => "Shipping",
"CurrencyID" => "CurrencyID"];
}?>
