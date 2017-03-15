<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorycategoriesdisplaylang";
public $dashboardTitle ="InventoryCategoriesDisplayLang";
public $breadCrumbTitle ="InventoryCategoriesDisplayLang";
public $idField ="ItemCategoryID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemCategoryID","ItemFamilyID","DisplayLang"];
public $gridFields = [

"ItemCategoryID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ItemFamilyID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"DisplayLang" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CategoryName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CategoryDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ItemCategoryID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemFamilyID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"DisplayLang" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CategoryName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CategoryDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CategoryLongDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"CategoryPictureURL" => [
"dbType" => "varchar(80)",
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
