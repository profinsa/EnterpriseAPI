<?php

/*
Name of Page: PayrollEmployeesAccrualTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesAccrualTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeesAccrualTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesAccrualTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesAccrualTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollEmployeesAccrualTypesList extends gridDataSource{
public $tableName = "payrollemployeesaccrualtypes";
public $dashboardTitle ="PayrollEmployeesAccrualTypes";
public $breadCrumbTitle ="PayrollEmployeesAccrualTypes";
public $idField ="AccrualID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AccrualID"];
public $gridFields = [

"AccrualID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AccrualDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
],
"AccrualFrequency" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AccrualGlAccount" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"AccrualID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AccrualDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"AccrualFrequency" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AccrualGlAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AccrualID" => "Accrual ID",
"AccrualDescription" => "Accrual Description",
"AccrualFrequency" => "Accrual Frequency",
"AccrualGlAccount" => "Accrual Gl Account"];
}?>
