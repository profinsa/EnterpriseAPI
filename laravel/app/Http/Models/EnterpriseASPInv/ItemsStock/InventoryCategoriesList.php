<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorycategories";
protected $gridFields =["ItemCategoryID","ItemFamilyID","CategoryName","CategoryDescription"];
public $dashboardTitle ="Inventory Categories";
public $breadCrumbTitle ="Inventory Categories";
public $idField ="ItemCategoryID";
public $editCategories = [
"Main" => [

"ItemCategoryID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemFamilyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CategoryName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CategoryDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"CategoryLongDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"CategoryPictureURL" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ItemCategoryID" => "Item Category ID",
"ItemFamilyID" => "Item Family ID",
"CategoryName" => "Category Name",
"CategoryDescription" => "Category Description",
"CategoryLongDescription" => "CategoryLongDescription",
"CategoryPictureURL" => "CategoryPictureURL"];
}?>
