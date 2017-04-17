<?php

/*
Name of Page: PurchaseTrackingHeaderList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Purchases\PurchaseTrackingHeaderList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PurchaseTrackingHeaderList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Purchases\PurchaseTrackingHeaderList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Purchases\PurchaseTrackingHeaderList.php
 
Calls:
MySql Database
 
Last Modified: 04/13/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "purchasetrackingheader";
public $dashboardTitle ="PurchaseTrackingHeader";
public $breadCrumbTitle ="PurchaseTrackingHeader";
public $idField ="PurchaseNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PurchaseNumber"];
public $gridFields = [

"PurchaseNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PurchaseDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"SpecialInstructions" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
],
"SpecialNeeds" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
],
"EnteredBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PurchaseNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseLongDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"SpecialInstructions" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"SpecialNeeds" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"EnteredBy" => [
"dbType" => "varchar(36)",
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
]
]];
public $columnNames = [

"PurchaseNumber" => "Purchase Number",
"PurchaseDescription" => "Purchase Description",
"SpecialInstructions" => "Special Instructions",
"SpecialNeeds" => "Special Needs",
"EnteredBy" => "Entered By",
"PurchaseLongDescription" => "Purchase Long Description",
"Approved" => "Approved",
"ApprovedBy" => "Approved By",
"ApprovedDate" => "Approved Date"];
}?>
