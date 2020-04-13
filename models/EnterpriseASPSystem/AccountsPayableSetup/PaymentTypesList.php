<?php

/*
Name of Page: PaymentTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsPayableSetup\PaymentTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PaymentTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsPayableSetup\PaymentTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsPayableSetup\PaymentTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "paymenttypes";
public $dashboardTitle ="Payment Types";
public $breadCrumbTitle ="Payment Types";
public $idField ="PaymentTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentTypeID"];
public $gridFields = [

"PaymentTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PaymentTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PaymentTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PaymentTypeID" => "Payment Type ID",
"PaymentTypeDescription" => "Payment Type Description"];
}?>
