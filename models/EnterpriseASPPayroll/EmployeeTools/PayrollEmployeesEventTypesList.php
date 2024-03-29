<?php

/*
Name of Page: PayrollEmployeesEventTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeesEventTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeesEventTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeesEventTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeesEventTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollEmployeesEventTypesList extends gridDataSource{
public $tableName = "payrollemployeeseventtypes";
public $dashboardTitle ="PayrollEmployeesEventTypes";
public $breadCrumbTitle ="PayrollEmployeesEventTypes";
public $idField ="EventID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EventID"];
public $gridFields = [

"EventID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EventDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EventID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EventDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EventID" => "Event ID",
"EventDescription" => "Event Description"];
}?>
