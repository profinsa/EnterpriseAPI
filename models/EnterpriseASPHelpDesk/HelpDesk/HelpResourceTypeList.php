<?php

/*
Name of Page: HelpResourceTypeList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpResourceTypeList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/HelpResourceTypeList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpResourceTypeList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpResourceTypeList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class HelpResourceTypeList extends gridDataSource{
public $tableName = "helpresourcetype";
public $dashboardTitle ="Help Resource Types";
public $breadCrumbTitle ="Help Resource Types";
public $idField ="ResourceType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ResourceType"];
public $gridFields = [

"ResourceType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ResourceTypeDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ResourceType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ResourceTypeDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ResourceType" => "Resource Type",
"ResourceTypeDescription" => "Resource Type Description"];
}?>
