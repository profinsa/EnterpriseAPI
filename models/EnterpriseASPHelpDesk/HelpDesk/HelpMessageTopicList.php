<?php

/*
Name of Page: HelpMessageTopicList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpMessageTopicList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/HelpMessageTopicList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpMessageTopicList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpMessageTopicList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "helpmessagetopic";
public $dashboardTitle ="Help Message Topics";
public $breadCrumbTitle ="Help Message Topics";
public $idField ="MessageHeadingID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","MessageHeadingID","MessageTopicId"];
public $gridFields = [

"MessageHeadingID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"MessageTopicId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"MessageTopicTitle" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"MessageTopicDescription" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"MessageHeadingID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicTitle" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicPictureURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"MessageHeadingID" => "Heading ID",
"MessageTopicId" => "Topic Id",
"MessageTopicTitle" => "Topic Title",
"MessageTopicDescription" => "Topic Description",
"MessageTopicPictureURL" => "Message Topic Picture URL",
"MessageTopicDate" => "Message Topic Date"];
}?>
