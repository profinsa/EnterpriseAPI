<?php

/*
Name of Page: InventoryItemsDisplayLangList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryItemsDisplayLangList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventoryItemsDisplayLangList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryItemsDisplayLangList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryItemsDisplayLangList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryitemsdisplaylang";
public $dashboardTitle ="InventoryItemsDisplayLang";
public $breadCrumbTitle ="InventoryItemsDisplayLang";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","DisplayLang"];
public $gridFields = [

"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"DisplayLang" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ItemName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ItemDescription" => [
    "dbType" => "varchar(80)",
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
"DisplayLang" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"IsActive" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ItemName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemLongDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemCategoryID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SalesDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"PictureURL" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"LargePictureURL" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemColor" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemStyle" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemCareInstructions" => [
"dbType" => "varchar(250)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"DisplayLang" => "Display Lang",
"ItemName" => "Item Name",
"ItemDescription" => "Item Description",
"IsActive" => "Is Active",
"ItemLongDescription" => "Item Long Description",
"ItemCategoryID" => "Item Category ID",
"SalesDescription" => "Sales Description",
"PurchaseDescription" => "Purchase Description",
"PictureURL" => "Picture URL",
"LargePictureURL" => "Large Picture URL",
"ItemColor" => "Item Color",
"ItemStyle" => "Item Style",
"ItemCareInstructions" => "Item Care Instructions",
"Approved" => "Approved",
"ApprovedBy" => "Approved By",
"ApprovedDate" => "Approved Date",
"EnteredBy" => "Entered By"];
}?>
