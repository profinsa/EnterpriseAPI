<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryitemsdisplaylang";
protected $gridFields =["ItemID","DisplayLang","ItemName","ItemDescription"];
public $dashboardTitle ="InventoryItemsDisplayLang";
public $breadCrumbTitle ="InventoryItemsDisplayLang";
public $idField ="ItemID";
public $editCategories = [
"Main" => [

"ItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"DisplayLang" => [
"inputType" => "text",
"defaultValue" => ""
],
"IsActive" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemLongDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemCategoryID" => [
"inputType" => "text",
"defaultValue" => ""
],
"SalesDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"PictureURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"LargePictureURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemColor" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemStyle" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemCareInstructions" => [
"inputType" => "text",
"defaultValue" => ""
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
