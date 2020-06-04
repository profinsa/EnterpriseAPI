<?php

/*
Name of Page: PayrollEmployeesAccrualList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesAccrualList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeesAccrualList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesAccrualList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesAccrualList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollEmployeesAccrualList extends gridDataSource{
public $tableName = "payrollemployeesaccrual";
public $dashboardTitle ="PayrollEmployeesAccrual";
public $breadCrumbTitle ="PayrollEmployeesAccrual";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","AccrualID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AmountAccrued" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"AmountUsed" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"LastAccrued" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AmountAccrued" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"AmountUsed" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"LastAccrued" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Active" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"AccrualID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"AmountAccrued" => "Amount Accrued",
"AmountUsed" => "Amount Used",
"LastAccrued" => "Last Accrued",
"Active" => "Active",
"Approved" => "Approved",
"ApprovedBy" => "Approved By",
"ApprovedDate" => "Approved Date",
"AccrualID" => "Accrual ID"];
}?>
