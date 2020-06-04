<?php

/*
Name of Page: ReceiptTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\ReceiptTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ReceiptTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\ReceiptTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\ReceiptTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class ReceiptTypesList extends gridDataSource{
public $tableName = "receipttypes";
public $dashboardTitle ="ReceiptTypes";
public $breadCrumbTitle ="ReceiptTypes";
public $idField ="ReceiptTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ReceiptTypeID"];
public $gridFields = [

"ReceiptTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReceiptTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ReceiptTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReceiptTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ReceiptTypeID" => "Receipt Type ID",
"ReceiptTypeDescription" => "Receipt Type Description"];
}?>
