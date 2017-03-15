<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorypricingmethods";
public $dashboardTitle ="Inventory Pricing Methods";
public $breadCrumbTitle ="Inventory Pricing Methods";
public $idField ="PricingMethodID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PricingMethodID"];
public $gridFields = [

"PricingMethodID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PricingMethodDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PricingMethodID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PricingMethodDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PricingMethodID" => "Pricing Method ID",
"PricingMethodDescription" => "Pricing Method Description"];
}?>
