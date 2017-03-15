<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryfamiliesdisplaylang";
public $dashboardTitle ="InventoryFamiliesDisplayLang";
public $breadCrumbTitle ="InventoryFamiliesDisplayLang";
public $idField ="ItemFamilyID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemFamilyID","DisplayLang"];
public $gridFields = [

"ItemFamilyID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"DisplayLang" => [
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
"DisplayLang" => [
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
"DisplayLang" => "Display Lang",
"FamilyName" => "Family Name",
"FamilyDescription" => "Family Description",
"FamilyLongDescription" => "FamilyLongDescription",
"FamilyPictureURL" => "FamilyPictureURL"];
}?>
