<?php

/*
Name of Page: TaxGroupsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\TaxGroupsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/TaxGroupsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\TaxGroupsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\TaxGroupsList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "taxgroups";
public $dashboardTitle ="Tax Groups";
public $breadCrumbTitle ="Tax Groups";
public $idField ="TaxGroupID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TaxGroupID"];
public $gridFields = [

"TaxGroupID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TotalPercent" => [
    "dbType" => "float",
    "format" => "{0:#.####}",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TaxGroupID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxGroupDetailID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TotalPercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"TaxOnTax" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
]
]];
public $columnNames = [

"TaxGroupID" => "Tax Group ID",
"TotalPercent" => "Total Percent",
"TaxGroupDetailID" => "Tax Group Detail ID",
"TaxOnTax" => "Tax On Tax"];
}?>
