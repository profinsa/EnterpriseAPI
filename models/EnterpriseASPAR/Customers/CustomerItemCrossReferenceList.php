<?php

/*
Name of Page: CustomerItemCrossReferenceList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Customers\CustomerItemCrossReferenceList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/CustomerItemCrossReferenceList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Customers\CustomerItemCrossReferenceList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Customers\CustomerItemCrossReferenceList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customeritemcrossreference";
public $dashboardTitle ="Customer Item Cross Reference";
public $breadCrumbTitle ="Customer Item Cross Reference";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","CustomerItemID"];
public $gridFields = [

"CustomerID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CustomerItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CustomerItemDescription" => [
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

"CustomerID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CustomerItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CustomerItemDescription" => [
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

"CustomerID" => "Customer ID",
"CustomerItemID" => "Customer Item ID",
"CustomerItemDescription" => "Customer Item Description",
"ItemID" => "Item ID",
"ItemDescription" => "Item Description"];
}?>
