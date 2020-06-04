<?php

/*
Name of Page: ReceiptMethodsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\ReceiptMethodsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ReceiptMethodsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\ReceiptMethodsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\ReceiptMethodsList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class ReceiptMethodsList extends gridDataSource{
public $tableName = "receiptmethods";
public $dashboardTitle ="ReceiptMethods";
public $breadCrumbTitle ="ReceiptMethods";
public $idField ="ReceiptMethodID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ReceiptMethodID"];
public $gridFields = [

"ReceiptMethodID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReceiptMethodDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ReceiptMethodID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReceiptMethodDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ReceiptMethodID" => "Receipt Method ID",
"ReceiptMethodDescription" => "Receipt Method Description"];
}?>
