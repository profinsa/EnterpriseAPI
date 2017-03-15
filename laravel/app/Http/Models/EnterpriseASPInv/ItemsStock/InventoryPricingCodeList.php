<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
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
"inputType" => "datetime",
"defaultValue" => "now"
],
"SaleEndDate" => [
"inputType" => "datetime",
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
"inputType" => "datetime",
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
