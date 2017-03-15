<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryfamilies";
public $dashboardTitle ="Inventory Families";
public $breadCrumbTitle ="Inventory Families";
public $idField ="ItemFamilyID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemFamilyID"];
public $gridFields = [

"ItemFamilyID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"FamilyName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"FamilyDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ItemFamilyID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"FamilyName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"FamilyDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"FamilyLongDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"FamilyPictureURL" => [
"dbType" => "varchar(80)",
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
