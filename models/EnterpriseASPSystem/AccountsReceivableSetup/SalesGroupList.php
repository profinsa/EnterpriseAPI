<?php

/*
Name of Page: SalesGroupList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\SalesGroupList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/SalesGroupList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\SalesGroupList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\AccountsReceivableSetup\SalesGroupList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class SalesGroupList extends gridDataSource{
public $tableName = "salesgroup";
public $dashboardTitle ="SalesGroup";
public $breadCrumbTitle ="SalesGroup";
public $idField ="SalesGroupID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","SalesGroupID","EmployeeID"];
public $gridFields = [

"SalesGroupID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"SalesGroupSupervisor" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ComissionPerc" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"ComissionType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"SalesGroupID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SalesGroupDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"SalesGroupSupervisor" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SplitCommission" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ComissionPerc" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"ComissionType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"SalesGroupID" => "Sales Group ID",
"EmployeeID" => "Employee ID",
"SalesGroupSupervisor" => "Sales Group Supervisor",
"ComissionPerc" => "Comission Perc",
"ComissionType" => "Comission Type",
"SalesGroupDescription" => "Sales Group Description",
"SplitCommission" => "Split Commission"];
}?>
