<?php

/*
Name of Page: InventoryCategoriesDisplayLangList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryCategoriesDisplayLangList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventoryCategoriesDisplayLangList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryCategoriesDisplayLangList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryCategoriesDisplayLangList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class InventoryCategoriesDisplayLangList extends gridDataSource{
public $tableName = "inventorycategoriesdisplaylang";
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
"CategoryLongDescription" => "Category Long Description",
"CategoryPictureURL" => "Category Picture URL"];
}?>
