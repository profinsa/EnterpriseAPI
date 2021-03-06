<?php

/*
Name of Page: ContactRegionsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\ContactRegionsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ContactRegionsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\ContactRegionsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\ContactRegionsList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class ContactRegionsList extends gridDataSource{
public $tableName = "contactregions";
public $dashboardTitle ="Contact Regions";
public $breadCrumbTitle ="Contact Regions";
public $idField ="ContactRegionID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ContactRegionID"];
public $gridFields = [

"ContactRegionID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactRegionDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ContactRegionID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactRegionDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContactRegionID" => "Contact Region ID",
"ContactRegionDescription" => "Contact Region Description"];
}?>
