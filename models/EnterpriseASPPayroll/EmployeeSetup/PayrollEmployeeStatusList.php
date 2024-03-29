<?php

/*
Name of Page: PayrollEmployeeStatusList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeeStatusList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeeStatusList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeeStatusList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeeStatusList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollEmployeeStatusList extends gridDataSource{
public $tableName = "payrollemployeestatus";
public $dashboardTitle ="PayrollEmployeeStatus";
public $breadCrumbTitle ="PayrollEmployeeStatus";
public $idField ="EmployeeStatusID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeStatusID"];
public $gridFields = [

"EmployeeStatusID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeStatusDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeStatusID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeStatusDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeStatusID" => "Employee Status ID",
"EmployeeStatusDescription" => "Employee Status Description"];
}?>
