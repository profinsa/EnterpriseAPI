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
class PayrollItemsList extends gridDataSource{
public $tableName = "payrollitems";
public $dashboardTitle ="PayrollItems";
public $breadCrumbTitle ="PayrollItems";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","PayrollItemID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PayrollItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"Basis" => [
    "dbType" => "varchar(20)",
    "inputType" => "text"
],
"PayrollItemTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ItemAmount" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"ItemPercent" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"PercentAmount" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"TotalAmount" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollItemDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Basis" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollItemTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"YTDMaximum" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Minimum" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"WageHigh" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"WageLow" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemPercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"PercentAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"TotalAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ApplyItem" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Employer" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"EmployerItemAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployerItemPercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"EmployerPercentAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployerTotalAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultItem" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line2" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line3" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line4" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line6a" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line6b" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line7" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line9" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line12" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box1" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box2" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box3" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box4" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box5" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box6" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box7" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box8" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box9" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box10" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box11" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box12" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box13" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box13b" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box14" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box15" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box17" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box18" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box20" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box21" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"GLEmployeeCreditAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLEmployerDebitAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLEmployerCreditAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"PayrollItemID" => "Payroll Item ID",
"Basis" => "Basis",
"PayrollItemTypeID" => "Payroll Item Type ID",
"ItemAmount" => "Item Amount",
"ItemPercent" => "Item Percent",
"PercentAmount" => "Percent Amount",
"TotalAmount" => "Total Amount",
"PayrollItemDescription" => "Payroll Item Description",
"YTDMaximum" => "YTD Maximum",
"Minimum" => "Minimum",
"WageHigh" => "Wage High",
"WageLow" => "Wage Low",
"ApplyItem" => "Apply Item",
"Employer" => "Employer",
"EmployerItemAmount" => "Employer Item Amount",
"EmployerItemPercent" => "Employer Item Percent",
"EmployerPercentAmount" => "Employer Percent Amount",
"EmployerTotalAmount" => "Employer Total Amount",
"DefaultItem" => "Default Item",
"Frm941Line2" => "Frm 941 Line2",
"Frm941Line3" => "Frm 941 Line3",
"Frm941Line4" => "Frm 941 Line4",
"Frm941Line6a" => "Frm 941 Line6a",
"Frm941Line6b" => "Frm 941 Line6b",
"Frm941Line7" => "Frm 941 Line7",
"Frm941Line9" => "Frm 941 Line9",
"Frm941Line12" => "Frm 941 Line12",
"W2Box1" => "W2 Box 1",
"W2Box2" => "W2 Box 2",
"W2Box3" => "W2 Box 3",
"W2Box4" => "W2 Box 4",
"W2Box5" => "W2 Box 5",
"W2Box6" => "W2 Box 6",
"W2Box7" => "W2 Box 7",
"W2Box8" => "W2 Box 8",
"W2Box9" => "W2 Box 9",
"W2Box10" => "W2 Box 10",
"W2Box11" => "W2 Box 11",
"W2Box12" => "W2 Box 12",
"W2Box13" => "W2 Box 13",
"W2Box13b" => "W2 Box 13b",
"W2Box14" => "W2 Box 14",
"W2Box15" => "W2 Box 15",
"W2Box17" => "W2 Box 17",
"W2Box18" => "W2 Box 18",
"W2Box20" => "W2 Box 20",
"W2Box21" => "W2 Box 21",
"GLEmployeeCreditAccount" => "GL Employee Credit Account",
"GLEmployerDebitAccount" => "GL Employer Debit Account",
"GLEmployerCreditAccount" => "GL Employer Credit Account"];
}?>
