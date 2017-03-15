<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "possetup";
protected $gridFields =["DefaultPricingCode"];
public $dashboardTitle ="POS Setup ";
public $breadCrumbTitle ="POS Setup ";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $editCategories = [
"Main" => [

"UsePricingCodes" => [
"inputType" => "text",
"defaultValue" => ""
],
"UseCustomerSpecificPricing" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultPricingCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultWarehouse" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultBin" => [
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
