<?php

/*
Name of Page: PayrollFedTaxTablesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollFedTaxTablesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollFedTaxTablesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollFedTaxTablesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollFedTaxTablesList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollfedtaxtables";
public $dashboardTitle ="PayrollFedTaxTables";
public $breadCrumbTitle ="PayrollFedTaxTables";
public $idField ="Country";
public $idFields = ["CompanyID","DivisionID","DepartmentID","Country","WithholdingStatus","StatusType","TaxBracket"];
public $gridFields = [

"WithholdingStatus" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TaxBracket" => [
    "dbType" => "double",
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
"StatusType" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"Country" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PayrollYear" => [
    "dbType" => "int(11)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"Country" => [
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

"WithholdingStatus" => "Withholding Status",
"TaxBracket" => "Tax Bracket",
"OverAmnt" => "Over Amnt",
"NotOver" => "Not Over",
"Cumulative" => "Cumulative",
"StatusType" => "Status Type",
"Country" => "Country",
"PayrollYear" => "Payroll Year",
"PayFrequency" => "Pay Frequency"];
}?>
