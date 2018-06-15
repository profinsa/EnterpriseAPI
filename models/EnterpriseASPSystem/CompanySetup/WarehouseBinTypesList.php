<?php

/*
Name of Page: WarehouseBinTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehouseBinTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/WarehouseBinTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehouseBinTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehouseBinTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "warehousebintypes";
public $dashboardTitle ="WarehouseBinTypes";
public $breadCrumbTitle ="WarehouseBinTypes";
public $idField ="WarehouseBinTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WarehouseBinTypeID"];
public $gridFields = [

"WarehouseBinTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WarehouseBinTypeDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WarehouseBinTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinTypeDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WarehouseBinTypeID" => "Warehouse Bin Type ID",
"WarehouseBinTypeDescription" => "Warehouse Bin Type Description"];
}?>
