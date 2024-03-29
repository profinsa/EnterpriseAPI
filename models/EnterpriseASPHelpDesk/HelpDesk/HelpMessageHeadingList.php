<?php

/*
Name of Page: HelpMessageHeadingList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpMessageHeadingList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/HelpMessageHeadingList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpMessageHeadingList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpMessageHeadingList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class HelpMessageHeadingList extends gridDataSource{
public $tableName = "helpmessageheading";
public $dashboardTitle ="Help Message Headings";
public $breadCrumbTitle ="Help Message Headings";
public $idField ="MessageHeadingId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","MessageHeadingId"];
public $gridFields = [

"MessageHeadingId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"MessageHeadingTitle" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"MessageHeadingDescription" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"MessageHeadingId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageHeadingTitle" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageHeadingDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageHeadingPictureURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageHeadingDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"MessageHeadingId" => "Heading Id",
"MessageHeadingTitle" => "Heading Title",
"MessageHeadingDescription" => "Heading Description",
"MessageHeadingPictureURL" => "Message Heading Picture URL",
"MessageHeadingDate" => "Message Heading Date"];
}?>
