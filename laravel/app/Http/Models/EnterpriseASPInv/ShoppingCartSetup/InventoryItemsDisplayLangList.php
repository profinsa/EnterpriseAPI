<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryitemsdisplaylang";
public $dashboardTitle ="InventoryItemsDisplayLang";
public $breadCrumbTitle ="InventoryItemsDisplayLang";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","DisplayLang"];
public $gridFields = [

"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"DisplayLang" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ItemName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ItemDescription" => [
    "dbType" => "varchar(80)",
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
"DisplayLang" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"IsActive" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemLongDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemCategoryID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SalesDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"PictureURL" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"LargePictureURL" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemColor" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemStyle" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemCareInstructions" => [
"dbType" => "varchar(250)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"DisplayLang" => "Display Lang",
"ItemName" => "Item Name",
"ItemDescription" => "Item Description",
"IsActive" => "IsActive",
"ItemLongDescription" => "ItemLongDescription",
"ItemCategoryID" => "ItemCategoryID",
"SalesDescription" => "SalesDescription",
"PurchaseDescription" => "PurchaseDescription",
"PictureURL" => "PictureURL",
"LargePictureURL" => "LargePictureURL",
"ItemColor" => "ItemColor",
"ItemStyle" => "ItemStyle",
"ItemCareInstructions" => "ItemCareInstructions",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"EnteredBy" => "EnteredBy"];
}?>
