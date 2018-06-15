<?php

/*
Name of Page: PayrollEmployeesEventsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeesEventsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeesEventsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeesEventsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeesEventsList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "payrollemployeesevents";
public $dashboardTitle ="PayrollEmployeesEvents";
public $breadCrumbTitle ="PayrollEmployeesEvents";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","EventDate","EventID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EventDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"EventID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EventTime" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"EventTimeUnits" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"Reason" => [
    "dbType" => "varchar(80)",
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
"EventDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EventID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EventTime" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"EventTimeUnits" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"Description" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"EventDate" => "Event Date",
"EventID" => "Event ID",
"EventTime" => "Event Time",
"EventTimeUnits" => "Event Time Units",
"Reason" => "Reason",
"Description" => "Description",
"Approved" => "Approved",
"ApprovedBy" => "Approved By",
"ApprovedDate" => "Approved Date"];
}?>
