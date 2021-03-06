<?php

/*
Name of Page: InventoryNoticifationsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryNoticifationsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventoryNoticifationsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryNoticifationsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryNoticifationsList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class InventoryNoticifationsList extends gridDataSource{
public $tableName = "inventorynoticifations";
public $dashboardTitle ="InventoryNoticifations";
public $breadCrumbTitle ="InventoryNoticifations";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","CustomerID"];
public $gridFields = [

"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CustomerID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"NotificationType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"Confirmed" => [
    "dbType" => "bigint(20)",
    "inputType" => "text"
],
"ApprovedBy" => [
    "dbType" => "varchar(36)",
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
"CustomerID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"NotificationType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Confirmed" => [
"dbType" => "bigint(20)",
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
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"CustomerID" => "Customer ID",
"NotificationType" => "Type",
"Confirmed" => "Confirmed",
"ApprovedBy" => "Approved By",
"Approved" => "Approved"];
}?>
