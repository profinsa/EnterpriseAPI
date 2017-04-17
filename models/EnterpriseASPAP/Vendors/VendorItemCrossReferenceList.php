<?php

/*
Name of Page: VendotItemCrossReferenceList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendotItemCrossReferenceList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/VendotItemCrossReferenceList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendotItemCrossReferenceList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendotItemCrossReferenceList.php
 
Calls:
MySql Database
 
Last Modified: 04/13/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendoritemcrossreference";
public $dashboardTitle ="Vendor Item Cross Reference";
public $breadCrumbTitle ="Vendor Item Cross Reference";
public $idField ="VendorID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID","VendorItemID"];
public $gridFields = [

"VendorID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"VendorItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"VendorItemDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ItemDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"VendorID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"VendorItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"VendorItemDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"VendorID" => "Vendor ID",
"VendorItemID" => "Vendor Item ID",
"VendorItemDescription" => "Vendor Item Description",
"ItemID" => "Item ID",
"ItemDescription" => "Item Description"];
}?>
