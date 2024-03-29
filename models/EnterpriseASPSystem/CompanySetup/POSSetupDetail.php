<?php

/*
Name of Page: POSSetupDetail model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\POSSetupDetail.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/POSSetupDetail for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\POSSetupDetail.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\POSSetupDetail.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class POSSetupDetail extends gridDataSource{
public $tableName = "possetup";
public $dashboardTitle ="POS Setup ";
public $breadCrumbTitle ="POS Setup ";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $gridFields = [

"DefaultPricingCode" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"UsePricingCodes" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"UseCustomerSpecificPricing" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"DefaultPricingCode" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultWarehouse" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultBin" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"DefaultPricingCode" => "Default Pricing Code",
"UsePricingCodes" => "Use Pricing Codes",
"UseCustomerSpecificPricing" => "Use Customer Specific Pricing",
"DefaultWarehouse" => "Default Warehouse",
"DefaultBin" => "Default Bin"];
}?>
