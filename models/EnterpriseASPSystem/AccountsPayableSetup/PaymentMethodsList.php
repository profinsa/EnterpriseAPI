<?php

/*
Name of Page: PaymentMethodsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsPayableSetup\PaymentMethodsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PaymentMethodsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsPayableSetup\PaymentMethodsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsPayableSetup\PaymentMethodsList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PaymentMethodsList extends gridDataSource{
public $tableName = "paymentmethods";
public $dashboardTitle ="Payment Methods";
public $breadCrumbTitle ="Payment Methods";
public $idField ="PaymentMethodID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentMethodID"];
public $gridFields = [

"PaymentMethodID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PaymentMethodDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PaymentMethodID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentMethodDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PaymentMethodID" => "Payment Method ID",
"PaymentMethodDescription" => "Payment Method Description"];
}?>
