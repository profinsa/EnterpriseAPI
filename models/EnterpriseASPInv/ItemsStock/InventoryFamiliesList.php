<?php

/*
Name of Page: InventoryFamiliesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryFamiliesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventoryFamiliesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryFamiliesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryFamiliesList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "inventoryfamilies";
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
"FamilyLongDescription" => "Family Long Description",
"FamilyPictureURL" => "Family Picture URL"];
}?>
