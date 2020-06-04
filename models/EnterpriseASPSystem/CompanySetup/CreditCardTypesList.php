<?php

/*
Name of Page: CreditCardTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CreditCardTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/CreditCardTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CreditCardTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CreditCardTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class CreditCardTypesList extends gridDataSource{
public $tableName = "creditcardtypes";
public $dashboardTitle ="Credit Card Types";
public $breadCrumbTitle ="Credit Card Types";
public $idField ="CreditCardTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CreditCardTypeID"];
public $gridFields = [

"CreditCardTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CreditCardDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"CreditCardTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CreditCardTypeID" => "Credit Card Type ID",
"CreditCardDescription" => "Credit Card Description"];
}?>
