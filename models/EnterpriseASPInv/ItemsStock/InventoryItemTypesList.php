<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryitemtypes";
public $dashboardTitle ="InventoryItemTypes";
public $breadCrumbTitle ="InventoryItemTypes";
public $idField ="ItemTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemTypeID"];
public $gridFields = [

"ItemTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ItemTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ItemTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Serialized" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
]
]];
public $columnNames = [

"ItemTypeID" => "Item Type ID",
"ItemTypeDescription" => "Item Type Description",
"Serialized" => "Serialized"];
}?>
