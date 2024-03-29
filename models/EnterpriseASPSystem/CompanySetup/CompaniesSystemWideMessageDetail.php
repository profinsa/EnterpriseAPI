<?php

/*
Name of Page: CompaniesSystemWideMessageDetail model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesSystemWideMessageDetail.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/CompaniesSystemWideMessageDetail for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesSystemWideMessageDetail.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesSystemWideMessageDetail.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class CompaniesSystemWideMessageDetail extends gridDataSource{
public $tableName = "companiessystemwidemessage";
public $dashboardTitle ="CompaniesSystemWideMessage ";
public $breadCrumbTitle ="CompaniesSystemWideMessage ";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $gridFields = [

// "SystemMessageAt" => [
//     "dbType" => "datetime",
//     "format" => "{0:d}",
//     "inputType" => "datetime"
// ],
"SystemMessageBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
    ],
    "SystemMessage" => [
        "dbType" => "varchar(120)",
        "inputType" => "text",
    ]
];

public $editCategories = [
"Main" => [

"SystemMessageAt" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"SystemMessageBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SystemMessage" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"SystemMessageAt" => "System Message At",
"SystemMessageBy" => "System Message By",
"SystemMessage" => "System Message"];
}?>
