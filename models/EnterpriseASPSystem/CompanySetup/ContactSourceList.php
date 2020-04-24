<?php

/*
Name of Page: ContactSourceList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\ContactSourceList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ContactSourceList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\ContactSourceList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\ContactSourceList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class ContactSourceList extends gridDataSource{
public $tableName = "contactsource";
public $dashboardTitle ="Contact Source";
public $breadCrumbTitle ="Contact Source";
public $idField ="ContactSourceID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ContactSourceID"];
public $gridFields = [

"ContactSourceID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactSourceDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ContactSourceID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactSourceDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContactSourceID" => "Contact Source ID",
"ContactSourceDescription" => "Contact Source Description"];
}?>
