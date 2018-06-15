<?php

/*
Name of Page: WorkOrderPriorityList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\MRPSetup\WorkOrderPriorityList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/WorkOrderPriorityList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\MRPSetup\WorkOrderPriorityList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\MRPSetup\WorkOrderPriorityList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "workorderpriority";
public $dashboardTitle ="Work Order Priorities";
public $breadCrumbTitle ="Work Order Priorities";
public $idField ="WorkOrderPriority";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderPriority"];
public $gridFields = [

"WorkOrderPriority" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WorkOrderPriorityDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WorkOrderPriority" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderPriorityDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkOrderPriority" => "Work Order Priority",
"WorkOrderPriorityDescription" => "Work Order Priority Description"];
}?>
