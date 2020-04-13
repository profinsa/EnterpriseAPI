<?php

/*
Name of Page: PayrollEmployeeTypeList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeeTypeList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeeTypeList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeeTypeList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeeTypeList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "payrollemployeetype";
public $dashboardTitle ="PayrollEmployeeType";
public $breadCrumbTitle ="PayrollEmployeeType";
public $idField ="EmployeeTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeTypeID"];
public $gridFields = [

"EmployeeTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeTypeID" => "Employee Type ID",
"EmployeeTypeDescription" => "Employee Type Description"];
}?>
