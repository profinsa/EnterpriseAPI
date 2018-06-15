<?php

/*
Name of Page: PayrollCountyTaxList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollCountyTaxList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollCountyTaxList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollCountyTaxList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollCountyTaxList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "payrollcountytax";
public $dashboardTitle ="PayrollCountyTax";
public $breadCrumbTitle ="PayrollCountyTax";
public $idField ="State";
public $idFields = ["CompanyID","DivisionID","DepartmentID","State","County"];
public $gridFields = [

"State" => [
    "dbType" => "varchar(2)",
    "inputType" => "text"
],
"County" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"StateName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CountyName" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CountyRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CountyWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CountyUIIRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CountyUIWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CountyOtherRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CountyOtherWageBase" => [
    "dbType" => "double",
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
"StateName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CountyName" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CountyRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CountyWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CountyUIIRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CountyUIWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CountyOtherRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CountyOtherWageBase" => [
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
]
]];
public $columnNames = [

"State" => "State",
"County" => "County",
"StateName" => "State Name",
"CountyName" => "County Name",
"CountyRate" => "County Rate",
"CountyWageBase" => "County Wage Base",
"CountyUIIRate" => "County UII Rate",
"CountyUIWageBase" => "County UI Wage Base",
"CountyOtherRate" => "County Other Rate",
"CountyOtherWageBase" => "County Other Wage Base",
"StandardDeductSingle" => "Standard Deduct Single",
"StandardDeductJoint" => "Standard Deduct Joint",
"Exemption" => "Exemption",
"Dependents" => "Dependents",
"Notes" => "Notes"];
}?>
