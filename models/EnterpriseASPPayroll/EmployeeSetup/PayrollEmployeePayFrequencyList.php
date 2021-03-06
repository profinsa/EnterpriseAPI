<?php

/*
Name of Page: PayrollEmployeePayFrequencyList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeePayFrequencyList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeePayFrequencyList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeePayFrequencyList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeePayFrequencyList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollEmployeePayFrequencyList extends gridDataSource{
public $tableName = "payrollemployeepayfrequency";
public $dashboardTitle ="PayrollEmployeePayFrequency";
public $breadCrumbTitle ="PayrollEmployeePayFrequency";
public $idField ="EmployeePayFrequencyID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeePayFrequencyID"];
public $gridFields = [

"EmployeePayFrequencyID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeePayFrequencyDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeePayFrequencyID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePayFrequencyDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeePayFrequencyID" => "Employee Pay Frequency ID",
"EmployeePayFrequencyDescription" => "Employee Pay Frequency Description"];
}?>
