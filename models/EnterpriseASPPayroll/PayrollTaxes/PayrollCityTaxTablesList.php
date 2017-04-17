<?php

/*
Name of Page: PayrollCityTaxTablesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollCityTaxTablesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollCityTaxTablesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollCityTaxTablesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollCityTaxTablesList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollcitytaxtables";
public $dashboardTitle ="PayrollCityTaxTables";
public $breadCrumbTitle ="PayrollCityTaxTables";
public $idField ="State";
public $idFields = ["CompanyID","DivisionID","DepartmentID","State","County","City","WithholdingStatus","TaxBracket","StatusType"];
public $gridFields = [

"State" => [
    "dbType" => "varchar(2)",
    "inputType" => "text"
],
"County" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"City" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WithholdingStatus" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TaxBracket" => [
    "dbType" => "double",
    "inputType" => "text"
],
"StatusType" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"OverAmnt" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"NotOver" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"Cumulative" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"PayrollYear" => [
    "dbType" => "int(11)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"State" => [
"dbType" => "varchar(2)",
"inputType" => "text",
"defaultValue" => ""
],
"County" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"City" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WithholdingStatus" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"StatusType" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxBracket" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"OverAmnt" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"NotOver" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Cumulative" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollYear" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"PayFrequency" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"State" => "State",
"County" => "County",
"City" => "City",
"WithholdingStatus" => "Withholding Status",
"TaxBracket" => "Tax Bracket",
"StatusType" => "Status Type",
"OverAmnt" => "Over Amnt",
"NotOver" => "Not Over",
"Cumulative" => "Cumulative",
"PayrollYear" => "Payroll Year",
"PayFrequency" => "Pay Frequency"];
}?>
