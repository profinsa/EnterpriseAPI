<?php

/*
Name of Page: HelpNewsBoardList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpNewsBoardList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/HelpNewsBoardList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpNewsBoardList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpNewsBoardList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "helpnewsboard";
public $dashboardTitle ="Help News Board";
public $breadCrumbTitle ="Help News Board";
public $idField ="NewsId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","NewsId"];
public $gridFields = [

"NewsId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"NewsProductId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"NewsTitle" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"NewsDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"NewsMessage" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"NewsId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"NewsProductId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"NewsTitle" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"NewsDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"NewsMessage" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"NewsId" => "News Id",
"NewsProductId" => "ProductI d",
"NewsTitle" => "Title",
"NewsDate" => "Date",
"NewsMessage" => "Message"];
}?>
