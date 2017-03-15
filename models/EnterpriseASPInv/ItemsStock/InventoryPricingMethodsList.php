<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorypricingmethods";
protected $gridFields =["PricingMethodID","PricingMethodDescription"];
public $dashboardTitle ="Inventory Pricing Methods";
public $breadCrumbTitle ="Inventory Pricing Methods";
public $idField ="PricingMethodID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PricingMethodID"];
public $editCategories = [
"Main" => [

"PricingMethodID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PricingMethodDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PricingMethodID" => "Pricing Method ID",
"PricingMethodDescription" => "Pricing Method Description"];
}?>
