<?php

/*
Name of Page: HelpSupportRequestTypeList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\HelpDesk\CRM\HelpSupportRequestTypeList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/HelpSupportRequestTypeList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\HelpDesk\CRM\HelpSupportRequestTypeList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\HelpDesk\CRM\HelpSupportRequestTypeList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpsupportrequesttype";
public $dashboardTitle ="Support Request Types";
public $breadCrumbTitle ="Support Request Types";
public $idField ="SupportRequestType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","SupportRequestType"];
public $gridFields = [

"SupportRequestType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"SupportRequestTypeDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"SupportRequestType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportRequestTypeDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"SupportRequestType" => "Support Request Type",
"SupportRequestTypeDescription" => "Support Request Type Description"];
}?>
