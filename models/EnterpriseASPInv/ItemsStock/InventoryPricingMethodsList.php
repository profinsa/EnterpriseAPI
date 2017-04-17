<?php

/*
Name of Page: InventoryPricingMethodsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryPricingMethodsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventoryPricingMethodsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryPricingMethodsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryPricingMethodsList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorypricingmethods";
public $dashboardTitle ="Inventory Pricing Methods";
public $breadCrumbTitle ="Inventory Pricing Methods";
public $idField ="PricingMethodID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PricingMethodID"];
public $gridFields = [

"PricingMethodID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PricingMethodDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PricingMethodID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PricingMethodDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PricingMethodID" => "Pricing Method ID",
"PricingMethodDescription" => "Pricing Method Description"];
}?>
