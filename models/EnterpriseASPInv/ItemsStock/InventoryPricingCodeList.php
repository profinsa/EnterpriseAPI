<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorypricingcode";
protected $gridFields =["ItemID","ItemPricingCode","Price","SalesPrice","SaleStartDate","SaleEndDate"];
public $dashboardTitle ="Inventory Pricing Code";
public $breadCrumbTitle ="Inventory Pricing Code";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","ItemPricingCode"];
public $editCategories = [
"Main" => [

"ItemID" => [
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
"CurrencyExchangeRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"Price" => [
"inputType" => "text",
"defaultValue" => ""
],
"MSRP" => [
"inputType" => "text",
"defaultValue" => ""
],
"HotItem" => [
"inputType" => "text",
"defaultValue" => ""
],
"FeaturedItem" => [
"inputType" => "text",
"defaultValue" => ""
],
"SaleItem" => [
"inputType" => "text",
"defaultValue" => ""
],
"SalesPrice" => [
"inputType" => "text",
"defaultValue" => ""
],
"SaleStartDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"SaleEndDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"EnteredBy" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"ItemPricingCode" => "Pricing Code",
"Price" => "Price",
"SalesPrice" => "Sales Price",
"SaleStartDate" => "Sale Start Date",
"SaleEndDate" => "Sale End Date",
"CurrencyID" => "CurrencyID",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"MSRP" => "MSRP",
"HotItem" => "HotItem",
"FeaturedItem" => "FeaturedItem",
"SaleItem" => "SaleItem",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"EnteredBy" => "EnteredBy"];
}?>
