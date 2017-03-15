<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorycategoriesdisplaylang";
protected $gridFields =["ItemCategoryID","ItemFamilyID","DisplayLang","CategoryName","CategoryDescription"];
public $dashboardTitle ="InventoryCategoriesDisplayLang";
public $breadCrumbTitle ="InventoryCategoriesDisplayLang";
public $idField ="ItemCategoryID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemCategoryID","ItemFamilyID","DisplayLang"];
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
"DisplayLang" => [
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
"DisplayLang" => "Display Lang",
"CategoryName" => "Category Name",
"CategoryDescription" => "Category Description",
"CategoryLongDescription" => "CategoryLongDescription",
"CategoryPictureURL" => "CategoryPictureURL"];
}?>
