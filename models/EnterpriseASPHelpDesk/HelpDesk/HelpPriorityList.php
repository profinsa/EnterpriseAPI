<?php

/*
Name of Page: HelpPriorityList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpPriorityList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/HelpPriorityList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpPriorityList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpPriorityList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helppriority";
public $dashboardTitle ="Help Priorities";
public $breadCrumbTitle ="Help Priorities";
public $idField ="Priority";
public $idFields = ["CompanyID","DivisionID","DepartmentID","Priority"];
public $gridFields = [

"Priority" => [
    "dbType" => "tinyint(3) unsigned",
    "inputType" => "text"
],
"PriorityDescription" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"Priority" => [
"dbType" => "tinyint(3) unsigned",
"inputType" => "text",
"defaultValue" => ""
],
"PriorityDescription" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"Priority" => "Priority",
"PriorityDescription" => "Priority Description"];
}?>
