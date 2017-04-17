<?php

/*
Name of Page: AuditLoginList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditLoginList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/AuditLoginList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditLoginList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditLoginList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "auditlogin";
public $dashboardTitle ="Audit Logins";
public $breadCrumbTitle ="Audit Logins";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","AuditID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AuditID" => [
    "dbType" => "bigint(20)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"LoginDateTime" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"MachineName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"IPAddress" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"LoginType" => [
    "dbType" => "int(11)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AuditID" => [
"dbType" => "bigint(20)",
"inputType" => "text",
"defaultValue" => ""
],
"LoginDateTime" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"MachineName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"IPAddress" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LoginType" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"AuditID" => "Audit ID",
"LoginDateTime" => "Login Date Time",
"MachineName" => "Machine Name",
"IPAddress" => "IP Address",
"LoginType" => "Login Type"];
}?>
