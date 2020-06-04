<?php

/*
Name of Page: PayrollEmployeeStatusTypeList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeeStatusTypeList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeeStatusTypeList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeeStatusTypeList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeeStatusTypeList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollEmployeeStatusTypeList extends gridDataSource{
public $tableName = "payrollemployeestatustype";
public $dashboardTitle ="Payroll Employee Status Types";
public $breadCrumbTitle ="Payroll Employee Status Types";
public $idField ="EmployeeStatusTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeStatusTypeID"];
public $gridFields = [

"EmployeeStatusTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeStatusTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeStatusTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeStatusTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeStatusTypeID" => "Employee Status Type ID",
"EmployeeStatusTypeDescription" => "Employee Status Type Description"];
}?>
