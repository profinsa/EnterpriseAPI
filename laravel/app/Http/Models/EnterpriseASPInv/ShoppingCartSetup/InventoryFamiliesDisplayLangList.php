<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryfamiliesdisplaylang";
protected $gridFields =["ItemFamilyID","DisplayLang","FamilyName","FamilyDescription"];
public $dashboardTitle ="InventoryFamiliesDisplayLang";
public $breadCrumbTitle ="InventoryFamiliesDisplayLang";
public $idField ="ItemFamilyID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemFamilyID","DisplayLang"];
public $editCategories = [
"Main" => [

"ItemFamilyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"DisplayLang" => [
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
"DisplayLang" => "Display Lang",
"FamilyName" => "Family Name",
"FamilyDescription" => "Family Description",
"FamilyLongDescription" => "FamilyLongDescription",
"FamilyPictureURL" => "FamilyPictureURL"];
}?>
