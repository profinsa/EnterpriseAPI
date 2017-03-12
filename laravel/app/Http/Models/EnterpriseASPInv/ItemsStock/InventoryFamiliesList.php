<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryfamilies";
protected $gridFields =["ItemFamilyID","FamilyName","FamilyDescription"];
public $dashboardTitle ="Inventory Families";
public $breadCrumbTitle ="Inventory Families";
public $idField ="ItemFamilyID";
public $editCategories = [
"Main" => [

"ItemFamilyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"FamilyName" => [
"inputType" => "text",
"defaultValue" => ""
],
"FamilyDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"FamilyLongDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"FamilyPictureURL" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ItemFamilyID" => "Item Family ID",
"FamilyName" => "Family Name",
"FamilyDescription" => "Family Description",
"FamilyLongDescription" => "FamilyLongDescription",
"FamilyPictureURL" => "FamilyPictureURL"];
}?>
