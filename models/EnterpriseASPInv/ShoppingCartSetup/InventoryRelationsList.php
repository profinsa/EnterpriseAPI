<?php

/*
Name of Page: InventoryRelationsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryRelationsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventoryRelationsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryRelationsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryRelationsList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "inventoryrelations";
public $dashboardTitle ="InventoryRelations";
public $breadCrumbTitle ="InventoryRelations";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID"];
public $gridFields = [

"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"RelatedItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"RelatedItemReason" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedItemReason" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"RelatedItemID" => "Related Item ID",
"RelatedItemReason" => "Related Item Reason"];
}?>
