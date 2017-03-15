<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
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
"inputType" => "text",
"defaultValue" => ""
],
"UseCustomerSpecificPricing" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
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
