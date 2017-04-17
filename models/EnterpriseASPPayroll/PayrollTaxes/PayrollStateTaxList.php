<?php

/*
Name of Page: PayrollStateTaxList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollStateTaxList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollStateTaxList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollStateTaxList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollStateTaxList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollstatetax";
public $dashboardTitle ="PayrollStateTax";
public $breadCrumbTitle ="PayrollStateTax";
public $idField ="State";
public $idFields = ["CompanyID","DivisionID","DepartmentID","State"];
public $gridFields = [

"State" => [
    "dbType" => "varchar(2)",
    "inputType" => "text"
],
"StateName" => [
    "dbType" => "char(30)",
    "inputType" => "text"
],
"SUTARate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"SUTAWageBase" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"SITRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"SITWageBase" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"SDIRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"SDIWageBase" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
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
"StateName" => [
"dbType" => "char(30)",
"inputType" => "text",
"defaultValue" => ""
],
"SUTARate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SUTAWageBase" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"SITRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SITWageBase" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"SDIRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SDIWageBase" => [
"dbType" => "decimal(19,4)",
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
]
]];
public $columnNames = [

"State" => "State",
"StateName" => "State Name",
"SUTARate" => "SUTA Rate",
"SUTAWageBase" => "SUTA Wage Base",
"SITRate" => "SIT Rate",
"SITWageBase" => "SIT Wage Base",
"SDIRate" => "SDI Rate",
"SDIWageBase" => "SDI Wage Base",
"StandardDeductSingle" => "Standard Deduct Single",
"StandardDeductJoint" => "Standard Deduct Joint",
"Exemption" => "Exemption",
"Dependents" => "Dependents",
"Notes" => "Notes"];
}?>
