<?php

/*
Name of Page: TaxGroupDetailList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\TaxGroupDetailList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/TaxGroupDetailList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\TaxGroupDetailList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\TaxGroupDetailList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "taxgroupdetail";
public $dashboardTitle ="Tax Group";
public $breadCrumbTitle ="Tax Group";
public $idField ="TaxGroupDetailID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TaxGroupDetailID"];
public $gridFields = [

"TaxGroupDetailID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TaxGroupDetailID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Description" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLTaxAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxPercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"TaxOrder" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxOnTax" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
]
]];
public $columnNames = [

"TaxGroupDetailID" => "Tax Group Detail ID",
"TotalPercent" => "Total Percent",
"TaxID" => "Tax ID",
"Description" => "Description",
"GLTaxAccount" => "GL Tax Account",
"TaxPercent" => "Tax Percent",
"TaxOrder" => "Tax Order",
"TaxOnTax" => "Tax On Tax"];
}?>
