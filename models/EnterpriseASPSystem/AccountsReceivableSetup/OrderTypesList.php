<?php

/*
Name of Page: OrderTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\OrderTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/OrderTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\OrderTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\OrderTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class OrderTypesList extends gridDataSource{
public $tableName = "ordertypes";
public $dashboardTitle ="Order Types";
public $breadCrumbTitle ="Order Types";
public $idField ="OrderTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","OrderTypeID"];
public $gridFields = [

"OrderTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"OrderTypeDescription" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"OrderTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"OrderTypeDescription" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"OrderTypeID" => "Order Type ID",
"OrderTypeDescription" => "Order Type Description"];
}?>
