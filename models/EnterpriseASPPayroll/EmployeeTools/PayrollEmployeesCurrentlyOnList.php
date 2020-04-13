<?php

/*
Name of Page: PayrollEmployeesCurrentlyOnList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeesCurrentlyOnList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeesCurrentlyOnList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeesCurrentlyOnList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeesCurrentlyOnList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "payrollemployeescurrentlyon";
public $dashboardTitle ="PayrollEmployeesCurrentlyOn";
public $breadCrumbTitle ="PayrollEmployeesCurrentlyOn";
public $idField ="LoginDate";
public $idFields = ["CompanyID","DivisionID","DepartmentID","LoginDate","EmployeeID"];
public $gridFields = [

"LoginDate" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"Status" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeEmail" => [
    "dbType" => "varchar(60)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"LoginDate" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Status" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeEmail" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"LoginDate" => "Login Date",
"EmployeeID" => "Employee ID",
"Status" => "Status",
"EmployeeEmail" => "Employee Email"];
}?>
