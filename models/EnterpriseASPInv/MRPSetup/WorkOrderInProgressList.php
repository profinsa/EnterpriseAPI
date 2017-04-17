<?php

/*
Name of Page: WorkOrderInProgressList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\MRPSetup\WorkOrderInProgressList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/WorkOrderInProgressList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\MRPSetup\WorkOrderInProgressList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\MRPSetup\WorkOrderInProgressList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "workorderinprogress";
public $dashboardTitle ="Work Order In Progress Types";
public $breadCrumbTitle ="Work Order In Progress Types";
public $idField ="WorkOrderInProgress";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderInProgress"];
public $gridFields = [

"WorkOrderInProgress" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WorkOrderInProgressDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WorkOrderInProgress" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderInProgressDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkOrderInProgress" => "In Progress Type",
"WorkOrderInProgressDescription" => "In Progress Description"];
}?>
