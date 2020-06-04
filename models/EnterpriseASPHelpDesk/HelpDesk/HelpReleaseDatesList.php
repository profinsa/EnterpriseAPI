<?php

/*
Name of Page: HelpReleaseDatesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpReleaseDatesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/HelpReleaseDatesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpReleaseDatesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpReleaseDatesList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class HelpReleaseDatesList extends gridDataSource{
public $tableName = "helpreleasedates";
public $dashboardTitle ="Help Release Dates";
public $breadCrumbTitle ="Help Release Dates";
public $idField ="ProductName";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ProductName","CurrentVersion"];
public $gridFields = [

"ProductName" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CurrentVersion" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"NextVersion" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"ReleaseDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"Notes" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ProductName" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrentVersion" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"NextVersion" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ReleaseDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Notes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ProductName" => "Product Name",
"CurrentVersion" => "Current Version",
"NextVersion" => "Next Version",
"ReleaseDate" => "Release Date",
"Notes" => "Notes"];
}?>
