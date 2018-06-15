<?php

/*
Name of Page: CompaniesNextNumbersList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesNextNumbersList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/CompaniesNextNumbersList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesNextNumbersList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesNextNumbersList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "companiesnextnumbers";
public $dashboardTitle ="CompaniesNextNumbers";
public $breadCrumbTitle ="CompaniesNextNumbers";
public $idField ="NextNumberName";
public $idFields = ["CompanyID","DivisionID","DepartmentID","NextNumberName"];
public $gridFields = [
];

public $editCategories = [
"Main" => [

"NextNumberName" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"NextNumberValue" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"NextNumberName" => "Next Number Name",
"NextNumberValue" => "Next Number Value"];
}?>
