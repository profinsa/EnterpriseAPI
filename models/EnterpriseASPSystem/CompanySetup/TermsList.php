<?php

/*
Name of Page: TermsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\TermsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/TermsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\TermsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\TermsList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class TermsList extends gridDataSource{
public $tableName = "terms";
public $dashboardTitle ="Terms";
public $breadCrumbTitle ="Terms";
public $idField ="TermsID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TermsID"];
public $gridFields = [

"TermsID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TermsDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"NetDays" => [
    "dbType" => "smallint(6)",
    "inputType" => "text"
],
"DiscountPercent" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"DiscountDays" => [
    "dbType" => "smallint(6)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TermsID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TermsDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"NetDays" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
],
"DiscountPercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"DiscountDays" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"TermsID" => "Terms ID",
"TermsDescription" => "Terms Description",
"NetDays" => "Net Days",
"DiscountPercent" => "Discount Percent",
"DiscountDays" => "Discount Days"];
}?>
