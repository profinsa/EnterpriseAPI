<?php

/*
Name of Page: WorkOrderStatusList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\MRPSetup\WorkOrderStatusList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/WorkOrderStatusList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\MRPSetup\WorkOrderStatusList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\MRPSetup\WorkOrderStatusList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "workorderstatus";
public $dashboardTitle ="WorkOrderStatus";
public $breadCrumbTitle ="WorkOrderStatus";
public $idField ="WorkOrderStatus";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderStatus"];
public $gridFields = [

"WorkOrderStatus" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WorkOrderStatusDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WorkOrderStatus" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderStatusDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkOrderStatus" => "Status",
"WorkOrderStatusDescription" => "Status Description"];
}?>
