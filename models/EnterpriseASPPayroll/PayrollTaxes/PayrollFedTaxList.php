<?php

/*
Name of Page: PayrollFedTaxList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollFedTaxList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollFedTaxList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollFedTaxList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollFedTaxList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "payrollfedtax";
public $dashboardTitle ="PayrollFedTax";
public $breadCrumbTitle ="PayrollFedTax";
public $idField ="Country";
public $idFields = ["CompanyID","DivisionID","DepartmentID","Country"];
public $gridFields = [

"Country" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"FITRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FITWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FICARate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FICAWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FUTARate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FUTAWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FICAMedRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FICAMedWageBase" => [
    "dbType" => "double",
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
"FITRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FITWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FICARate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FICAWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FUTARate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FUTAWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FICAMedRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FICAMedWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"StandardDeductSingle" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"StandardDeductJoint" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Exemption" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Dependents" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"CountryName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"Country" => "Country",
"FITRate" => "FIT Rate",
"FITWageBase" => "FIT Wage Base",
"FICARate" => "FICA Rate",
"FICAWageBase" => "FICA Wage Base",
"FUTARate" => "FUTA Rate",
"FUTAWageBase" => "FUTA Wage Base",
"FICAMedRate" => "FICA Med Rate",
"FICAMedWageBase" => "FICA Med Wage Base",
"StandardDeductSingle" => "Standard Deduct Single",
"StandardDeductJoint" => "Standard Deduct Joint",
"Exemption" => "Exemption",
"Dependents" => "Dependents",
"Notes" => "Notes",
"CountryName" => "Country Name"];
}?>
