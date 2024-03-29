<?php

/*
Name of Page: PayrollItemsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollItemsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollItemsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollItemsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollItemsList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollItemBasisList extends gridDataSource{
public $tableName = "payrollitembasis";
public $dashboardTitle ="PayrollItemBasis";
public $breadCrumbTitle ="PayrollItemBasis";
public $idField ="PayrollItemBasisID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PayrollItemBasisID"];
public $gridFields = [

"PayrollItemBasisID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PayrollItemBasisDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PayrollItemBasisID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollItemBasisDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PayrollItemBasisID" => "Payroll Item Basis ID",
"PayrollItemBasisDescription" => "Payroll Item Basis Description"];
}?>
