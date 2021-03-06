<?php

/*
Name of Page: PayrollEmployeesTaskPriorityList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesTaskPriorityList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeesTaskPriorityList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesTaskPriorityList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesTaskPriorityList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollEmployeesTaskPriorityList extends gridDataSource{
public $tableName = "payrollemployeestaskpriority";
public $dashboardTitle ="PayrollEmployeesTaskPriority";
public $breadCrumbTitle ="PayrollEmployeesTaskPriority";
public $idField ="PriorityID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PriorityID"];
public $gridFields = [

"PriorityID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PriorityDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PriorityID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PriorityDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PriorityID" => "Priority ID",
"PriorityDescription" => "Priority Description"];
}?>
