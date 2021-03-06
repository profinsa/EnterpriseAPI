<?php

/*
Name of Page: WarehouseBinsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehouseBinsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/WarehouseBinsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehouseBinsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehouseBinsList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class TimeUnitsList extends gridDataSource{
public $tableName = "timeunits";
public $dashboardTitle ="TimeUnits";
public $breadCrumbTitle ="TimeUnits";
public $idField ="TimeUnitID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TimeUnitID"];
public $gridFields = [

"TimeUnitID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TimeUnitDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TimeUnitID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TimeUnitDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"TimeUnitID" => "Time Unit ID",
"TimeUnitDescription" => "Time Unit Description"];
}?>
