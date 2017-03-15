<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorysubstitutions";
public $dashboardTitle ="InventorySubstitutions";
public $breadCrumbTitle ="InventorySubstitutions";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $gridFields = [

"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"SubstituteItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SubstituteItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"SubstituteItemID" => "Substitute Item ID"];
}?>
