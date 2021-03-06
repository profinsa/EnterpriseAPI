<?php

/*
Name of Page: PayrollCityTaxList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollCityTaxList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollCityTaxList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollCityTaxList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollCityTaxList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollCityTaxList extends gridDataSource{
public $tableName = "payrollcitytax";
public $dashboardTitle ="PayrollCityTax";
public $breadCrumbTitle ="PayrollCityTax";
public $idField ="State";
public $idFields = ["CompanyID","DivisionID","DepartmentID","State","County","City"];
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
"StateName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CountyName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CityName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CityRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CityWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CityUIIRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CityOtherWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CityUIWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CityOtherRate" => [
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
"City" => [
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
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CityName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CityRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CityWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CityUIIRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CityUIWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CityOtherRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CityOtherWageBase" => [
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
"City" => "City",
"StateName" => "State Name",
"CountyName" => "County Name",
"CityName" => "City Name",
"CityRate" => "City Rate",
"CityWageBase" => "City WageBase",
"CityUIIRate" => "City UIIRate",
"CityOtherWageBase" => "City Other Wage Base",
"CityUIWageBase" => "City UI Wage Base",
"CityOtherRate" => "City Other Rate",
"StandardDeductSingle" => "Standard Deduct Single",
"StandardDeductJoint" => "Standard Deduct Joint",
"Exemption" => "Exemption",
"Dependents" => "Dependents",
"Notes" => "Notes"];
}?>
