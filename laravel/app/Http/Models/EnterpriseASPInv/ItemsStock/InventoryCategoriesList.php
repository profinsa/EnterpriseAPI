<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorycategories";
public $dashboardTitle ="Inventory Categories";
public $breadCrumbTitle ="Inventory Categories";
public $idField ="ItemCategoryID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemCategoryID","ItemFamilyID"];
public $gridFields = [

"ItemCategoryID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ItemFamilyID" => [
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
"CategoryName" => "Category Name",
"CategoryDescription" => "Category Description",
"CategoryLongDescription" => "CategoryLongDescription",
"CategoryPictureURL" => "CategoryPictureURL"];
}?>
