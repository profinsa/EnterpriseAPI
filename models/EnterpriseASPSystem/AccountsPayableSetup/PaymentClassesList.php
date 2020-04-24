<?php

/*
Name of Page: PaymentClassesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsPayableSetup\PaymentClassesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PaymentClassesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsPayableSetup\PaymentClassesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsPayableSetup\PaymentClassesList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PaymentClassesList extends gridDataSource{
public $tableName = "paymentclasses";
public $dashboardTitle ="Payment Classes";
public $breadCrumbTitle ="Payment Classes";
public $idField ="PaymentClassID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentClassID"];
public $gridFields = [

"PaymentClassID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PaymentClassesDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PaymentClassID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentClassesDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PaymentClassID" => "Payment Class ID",
"PaymentClassesDescription" => "Payment Classes Description"];
}?>
