<?php

/*
Name of Page: PayrollW2DetailList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollW2DetailList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollW2DetailList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollW2DetailList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollW2DetailList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollw2detail";
public $dashboardTitle ="PayrollW2Detail";
public $breadCrumbTitle ="PayrollW2Detail";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"W2Year" => [
    "dbType" => "varchar(4)",
    "inputType" => "text"
],
"W2ControlNumber" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"EmployeeName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"EmployeeSSNumber" => [
    "dbType" => "varchar(15)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Year" => [
"dbType" => "varchar(4)",
"inputType" => "text",
"defaultValue" => ""
],
"W2ControlNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeSSNumber" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeZip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeCountry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Box1" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box2" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box3" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box4" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box5" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box6" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box7" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box8" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box9" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box10" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box11" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box12" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box13" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box13b" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Box14" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box15" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check1" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Box15Check2" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Box15Check3" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Box15Check4" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Box15Check5" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Box15Check6" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Box15Check7" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Box17" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box18" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box19" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box20" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box21" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"W2Year" => "W2 Year",
"W2ControlNumber" => "W2 Control Number",
"EmployeeName" => "Employee Name",
"EmployeeSSNumber" => "Employee SS Number",
"EmployeeAddress1" => "Employee Address 1",
"EmployeeAddress2" => "Employee Address 2",
"EmployeeCity" => "Employee City",
"EmployeeState" => "Employee State",
"EmployeeZip" => "Employee Zip",
"EmployeeCountry" => "Employee Country",
"Box1" => "Box 1",
"Box2" => "Box 2",
"Box3" => "Box 3",
"Box4" => "Box 4",
"Box5" => "Box 5",
"Box6" => "Box 6",
"Box7" => "Box 7",
"Box8" => "Box 8",
"Box9" => "Box 9",
"Box10" => "Box 10",
"Box11" => "Box 11",
"Box12" => "Box 12",
"Box13" => "Box 13",
"Box13b" => "Box 13b",
"Box14" => "Box 14",
"Box15" => "Box 15",
"Box15Check1" => "Box 15 Check 1",
"Box15Check2" => "Box 15 Check 2",
"Box15Check3" => "Box 15 Check 3",
"Box15Check4" => "Box 15 Check 4",
"Box15Check5" => "Box 15 Check 5",
"Box15Check6" => "Box 15 Check 6",
"Box15Check7" => "Box 15 Check 7",
"Box17" => "Box 17",
"Box18" => "Box 18",
"Box19" => "Box 19",
"Box20" => "Box 20",
"Box21" => "Box 21"];
}?>
