<?php

/*
Name of Page: InventoryAdjustmentTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\InventoryAdjustments\InventoryAdjustmentTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventoryAdjustmentTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\InventoryAdjustments\InventoryAdjustmentTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\InventoryAdjustments\InventoryAdjustmentTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryadjustmenttypes";
public $dashboardTitle ="Inventory Adjustment Types";
public $breadCrumbTitle ="Inventory Adjustment Types";
public $idField ="AdjustmentTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AdjustmentTypeID"];
public $gridFields = [

"AdjustmentTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AdjustmentTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"AdjustmentTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AdjustmentTypeID" => "Adjustment Type ID",
"AdjustmentTypeDescription" => "Adjustment Type Description"];
}?>
