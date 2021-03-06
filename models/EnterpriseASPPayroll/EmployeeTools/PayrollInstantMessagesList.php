<?php

/*
Name of Page: PayrollInstantMessagesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollInstantMessagesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollInstantMessagesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollInstantMessagesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollInstantMessagesList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollInstantMessagesList extends gridDataSource{
public $tableName = "payrollinstantmessages";
public $dashboardTitle ="PayrollInstantMessages";
public $breadCrumbTitle ="PayrollInstantMessages";
public $idField ="InstantMessageID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","InstantMessageID"];
public $gridFields = [

"InstantMessageID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"InstantMessageText" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
],
"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeEmail" => [
    "dbType" => "varchar(60)",
    "inputType" => "text"
],
"TimeSent" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"InstantMessageID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"InstantMessageText" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeEmail" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"TimeSent" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"InstantMessageID" => "Message ID",
"InstantMessageText" => "Message Text",
"EmployeeID" => "Employee ID",
"EmployeeEmail" => "Employee Email",
"TimeSent" => "Time Sent"];
}?>
