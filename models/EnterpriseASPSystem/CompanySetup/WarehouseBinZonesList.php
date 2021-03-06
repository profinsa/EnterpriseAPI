<?php

/*
Name of Page: WarehouseBinZonesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehouseBinZonesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/WarehouseBinZonesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehouseBinZonesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehouseBinZonesList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class WarehouseBinZonesList extends gridDataSource{
public $tableName = "warehousebinzones";
public $dashboardTitle ="WarehouseBinZones";
public $breadCrumbTitle ="WarehouseBinZones";
public $idField ="WarehouseBinZoneID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WarehouseBinZoneID"];
public $gridFields = [

"WarehouseBinZoneID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WarehouseBinZoneDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WarehouseBinZoneID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinZoneDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WarehouseBinZoneID" => "Warehouse Bin Zone ID",
"WarehouseBinZoneDescription" => "Warehouse Bin Zone Description"];
}?>
