<?php

/*
Name of Page: PayrollItemTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollItemTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollItemTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollItemTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollItemTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollItemTypesList extends gridDataSource{
public $tableName = "payrollitemtypes";
public $dashboardTitle ="PayrollItemTypes";
public $breadCrumbTitle ="PayrollItemTypes";
public $idField ="PayrollItemTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PayrollItemTypeID"];
public $gridFields = [

"PayrollItemTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PayrollItemTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PayrollItemTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollItemTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PayrollItemTypeID" => "Payroll Item Type ID",
"PayrollItemTypeDescription" => "Payroll Item Type Description"];
}?>
