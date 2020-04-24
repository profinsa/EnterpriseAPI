<?php

/*
Name of Page: HelpProblemTypeList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpProblemTypeList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/HelpProblemTypeList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpProblemTypeList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpProblemTypeList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class HelpProblemTypeList extends gridDataSource{
public $tableName = "helpproblemtype";
public $dashboardTitle ="Help Problem Types";
public $breadCrumbTitle ="Help Problem Types";
public $idField ="ProblemType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ProblemType"];
public $gridFields = [

"ProblemType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ProblemTypeDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ProblemType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemTypeDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ProblemType" => "Problem Type",
"ProblemTypeDescription" => "Problem Type Description"];
}?>
