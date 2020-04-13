<?php

/*
Name of Page: PayrollCheckTypeList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollProcessing\PayrollCheckTypeList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollCheckTypeList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollProcessing\PayrollCheckTypeList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollProcessing\PayrollCheckTypeList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "payrollchecktype";
public $dashboardTitle ="PayrollCheckType";
public $breadCrumbTitle ="PayrollCheckType";
public $idField ="CheckTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CheckTypeID"];
public $gridFields = [

"CheckTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CheckTypeDescription" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"CheckTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CheckTypeDescription" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CheckTypeID" => "Check Type ID",
"CheckTypeDescription" => "Check Type Description"];
}?>
