<?php

/*
Name of Page: PayrollEmployeesTaskTypeList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesTaskTypeList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeesTaskTypeList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesTaskTypeList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesTaskTypeList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestasktype";
public $dashboardTitle ="PayrollEmployeesTaskType";
public $breadCrumbTitle ="PayrollEmployeesTaskType";
public $idField ="TaskTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TaskTypeID"];
public $gridFields = [

"TaskTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TaskTypeDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TaskTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkFlowTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaskTypeDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"TaskTypeRule" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"TaskTypeManager" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"TaskTypeID" => "Task Type ID",
"TaskTypeDescription" => "Task Type Description",
"WorkFlowTypeID" => "Work Flow Type ID",
"TaskTypeRule" => "Task Type Rule",
"TaskTypeManager" => "Task Type Manager"];
}?>
