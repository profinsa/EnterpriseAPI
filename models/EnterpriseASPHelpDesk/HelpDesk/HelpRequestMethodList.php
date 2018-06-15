<?php

/*
Name of Page: HelpRequestMethodList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpRequestMethodList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/HelpRequestMethodList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpRequestMethodList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpRequestMethodList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "helprequestmethod";
public $dashboardTitle ="Help Request Methods";
public $breadCrumbTitle ="Help Request Methods";
public $idField ="RequestMethod";
public $idFields = ["CompanyID","DivisionID","DepartmentID","RequestMethod"];
public $gridFields = [

"RequestMethod" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"RequestMethodDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"RequestMethod" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RequestMethodDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"RequestMethod" => "Request Method",
"RequestMethodDescription" => "Request Method Description"];
}?>
