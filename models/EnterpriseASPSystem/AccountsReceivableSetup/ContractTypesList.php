<?php

/*
Name of Page: ContractTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\ContractTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ContractTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\ContractTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\ContractTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class ContractTypesList extends gridDataSource{
public $tableName = "contracttypes";
public $dashboardTitle ="Contract Types";
public $breadCrumbTitle ="Contract Types";
public $idField ="ContractTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ContractTypeID"];
public $gridFields = [

"ContractTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContractTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ContractTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContractTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContractTypeID" => "Contract Type ID",
"ContractTypeDescription" => "Contract Type Description"];
}?>
