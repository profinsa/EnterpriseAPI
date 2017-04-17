<?php

/*
Name of Page: ExpenseReportItemsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\ExpenseReports\ExpenseReportItemsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ExpenseReportItemsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\ExpenseReports\ExpenseReportItemsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\ExpenseReports\ExpenseReportItemsList.php
 
Calls:
MySql Database
 
Last Modified: 04/13/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "expensereportitems";
public $dashboardTitle ="ExpenseReportItems";
public $breadCrumbTitle ="ExpenseReportItems";
public $idField ="ExpenseReportItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ExpenseReportItemID"];
public $gridFields = [

"ExpenseReportItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ExpenseReportItemDescription" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ExpsneseReportGLAccount" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ExpenseReportMilageRate" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ExpenseReportItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportItemDescription" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpsneseReportGLAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMilageRate" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ExpenseReportItemID" => "Expense Report Item ID",
"ExpenseReportItemDescription" => "Description",
"ExpsneseReportGLAccount" => "GL Account",
"ExpenseReportMilageRate" => "Milage Rate"];
}?>
