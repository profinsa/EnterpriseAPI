<?php

/*
Name of Page: PayrollEmployeeDepartmentList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeeDepartmentList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeeDepartmentList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeeDepartmentList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeeDepartmentList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeedepartment";
public $dashboardTitle ="PayrollEmployeeDepartment";
public $breadCrumbTitle ="PayrollEmployeeDepartment";
public $idField ="EmployeeDepartmentID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeDepartmentID"];
public $gridFields = [

"EmployeeDepartmentID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeDepartmentDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeDepartmentID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeDepartmentDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeDepartmentID" => "Employee Department ID",
"EmployeeDepartmentDescription" => "Employee Department Description"];
}?>
