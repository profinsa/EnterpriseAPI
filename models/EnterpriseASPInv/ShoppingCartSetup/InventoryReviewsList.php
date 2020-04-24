<?php

/*
Name of Page: InventoryReviewsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryReviewsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventoryReviewsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryReviewsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryReviewsList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class InventoryReviewsList extends gridDataSource{
public $tableName = "inventoryreviews";
public $dashboardTitle ="InventoryReviews";
public $breadCrumbTitle ="InventoryReviews";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","ReviewID"];
public $gridFields = [

"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReviewID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReviewBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReviewDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"Rating" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"Helpful" => [
    "dbType" => "int(11)",
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
"ReviewID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReviewBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReviewDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Review" => [
"dbType" => "varchar(999)",
"inputType" => "text",
"defaultValue" => ""
],
"Rating" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"Helpful" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"Views" => [
"dbType" => "int(11)",
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
"ReviewID" => "Review ID",
"ReviewBy" => "Review By",
"ReviewDate" => "Review Date",
"Rating" => "Rating",
"Helpful" => "Helpful",
"ApprovedBy" => "Approved By",
"Review" => "Review",
"Views" => "Views",
"Approved" => "Approved"];
}?>
