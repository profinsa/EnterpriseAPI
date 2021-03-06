<?php

/*
Name of Page: HelpStatusList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpStatusList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/HelpStatusList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpStatusList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpStatusList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class HelpStatusList extends gridDataSource{
public $tableName = "helpstatus";
public $dashboardTitle ="Help Statuses";
public $breadCrumbTitle ="Help Statuses";
public $idField ="StatusId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","StatusId"];
public $gridFields = [

"StatusId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"StatusDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"StatusId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"StatusDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"StatusId" => "Status Id",
"StatusDescription" => "Status Description"];
}?>
