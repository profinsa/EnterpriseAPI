<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "possetup";
public $dashboardTitle ="POS Setup ";
public $breadCrumbTitle ="POS Setup ";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $gridFields = [

"DefaultPricingCode" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"UsePricingCodes" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"UseCustomerSpecificPricing" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"DefaultPricingCode" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultWarehouse" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultBin" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"DefaultPricingCode" => "Default Pricing Code",
"UsePricingCodes" => "UsePricingCodes",
"UseCustomerSpecificPricing" => "UseCustomerSpecificPricing",
"DefaultWarehouse" => "DefaultWarehouse",
"DefaultBin" => "DefaultBin"];
}?>
