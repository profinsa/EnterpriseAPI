<?php

/*
Name of Page: ContactIndustryList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\ContactIndustryList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ContactIndustryList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\ContactIndustryList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\ContactIndustryList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class ContactIndustryList extends gridDataSource{
public $tableName = "contactindustry";
public $dashboardTitle ="Contact Industry";
public $breadCrumbTitle ="Contact Industry";
public $idField ="ContactIndustryID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ContactIndustryID"];
public $gridFields = [

"ContactIndustryID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactIndustryDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ContactIndustryID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactIndustryDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContactIndustryID" => "Contact Industry ID",
"ContactIndustryDescription" => "Contact Industry Description"];
}?>
