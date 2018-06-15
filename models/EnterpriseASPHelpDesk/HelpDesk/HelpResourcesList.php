<?php

/*
Name of Page: HelpResourcesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpResourcesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/HelpResourcesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpResourcesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpResourcesList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "helpresources";
public $dashboardTitle ="Help Resources";
public $breadCrumbTitle ="Help Resources";
public $idField ="ResourceId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ResourceId"];
public $gridFields = [

"ResourceId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ResourceType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ResourceProductId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ResourceRank" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"ResourceLink" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"ResourceDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ResourceId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ResourceType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ResourceProductId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ResourceRank" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"ResourceLink" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ResourceDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ResourceId" => "Resource Id",
"ResourceType" => "Resource Type",
"ResourceProductId" => "Product Id",
"ResourceRank" => "Rank",
"ResourceLink" => "Link",
"ResourceDescription" => "Description"];
}?>
