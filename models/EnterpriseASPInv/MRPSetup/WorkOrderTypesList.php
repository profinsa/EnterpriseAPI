<?php

/*
Name of Page: WorkOrderTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\MRPSetup\WorkOrderTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/WorkOrderTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\MRPSetup\WorkOrderTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\MRPSetup\WorkOrderTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "workordertypes";
public $dashboardTitle ="Work Order Types";
public $breadCrumbTitle ="Work Order Types";
public $idField ="WorkOrderTypes";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderTypes"];
public $gridFields = [

"WorkOrderTypes" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WorkOrderTypesDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WorkOrderTypes" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderTypesDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkOrderTypes" => "Type",
"WorkOrderTypesDescription" => "Type Description"];
}?>
