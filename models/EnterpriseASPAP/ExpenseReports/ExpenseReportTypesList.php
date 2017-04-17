<?php

/*
Name of Page: ExpenseReportTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\ExpenseReports\ExpenseReportTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ExpenseReportTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\ExpenseReports\ExpenseReportTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\ExpenseReports\ExpenseReportTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/13/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "expensereporttypes";
public $dashboardTitle ="ExpenseReportTypes";
public $breadCrumbTitle ="ExpenseReportTypes";
public $idField ="ExpenseReportType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ExpenseReportType"];
public $gridFields = [

"ExpenseReportType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ExpenseReportTypeDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ExpenseReportType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportTypeDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ExpenseReportType" => "Expense Report Type",
"ExpenseReportTypeDescription" => "Description"];
}?>
