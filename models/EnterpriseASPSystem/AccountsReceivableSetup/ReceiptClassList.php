<?php

/*
Name of Page: ReceiptClassList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\ReceiptClassList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ReceiptClassList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\ReceiptClassList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\ReceiptClassList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class ReceiptClassList extends gridDataSource{
public $tableName = "receiptclass";
public $dashboardTitle ="Receipt Class";
public $breadCrumbTitle ="Receipt Class";
public $idField ="ReceiptClassID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ReceiptClassID"];
public $gridFields = [

"ReceiptClassID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReceiptClassDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ReceiptClassID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReceiptClassDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ReceiptClassID" => "Receipt Class ID",
"ReceiptClassDescription" => "Receipt Class Description"];
}?>
