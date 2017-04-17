<?php

/*
Name of Page: PayrollEmployeesAccrualFrequencyList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesAccrualFrequencyList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeesAccrualFrequencyList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesAccrualFrequencyList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesAccrualFrequencyList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeesaccrualfrequency";
public $dashboardTitle ="PayrollEmployeesAccrualFrequency";
public $breadCrumbTitle ="PayrollEmployeesAccrualFrequency";
public $idField ="AccrualFrequency";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AccrualFrequency"];
public $gridFields = [

"AccrualFrequency" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AccruslFrequencyDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"AccrualFrequencyRate" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"AccrualFrequencyUnit" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"AccrualFrequency" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AccruslFrequencyDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"AccrualFrequencyRate" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"AccrualFrequencyUnit" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AccrualFrequency" => "Accrual Frequency",
"AccruslFrequencyDescription" => "Accrusl Frequency Description",
"AccrualFrequencyRate" => "Accrual Frequency Rate",
"AccrualFrequencyUnit" => "Accrual Frequency Unit"];
}?>
