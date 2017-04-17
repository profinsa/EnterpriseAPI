<?php

/*
Name of Page: DepartmentsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DepartmentsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/DepartmentsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DepartmentsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DepartmentsList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "departments";
public $dashboardTitle ="Departments";
public $breadCrumbTitle ="Departments";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $gridFields = [

"DepartmentName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"DepartmentDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"DepartmentPhone" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"DepartmentName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentZip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentCountry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentPhone" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentFax" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentEmail" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentWebAddress" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentNotes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"DepartmentID" => "Department ID",
"DepartmentName" => "Department Name",
"DepartmentDescription" => "Department Description",
"DepartmentPhone" => "Department Phone",
"DepartmentAddress1" => "Department Address 1",
"DepartmentAddress2" => "Department Address 2",
"DepartmentCity" => "Department City",
"DepartmentState" => "Department State",
"DepartmentZip" => "Department Zip",
"DepartmentCountry" => "Department Country",
"DepartmentFax" => "Department Fax",
"DepartmentEmail" => "Department Email",
"DepartmentWebAddress" => "Department Web Address",
"DepartmentNotes" => "Department Notes"];
}?>
