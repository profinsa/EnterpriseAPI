<?php

/*
Name of Page: PayrollItemsMasterList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollItemsMasterList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollItemsMasterList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollItemsMasterList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollTaxes\PayrollItemsMasterList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "payrollitemsmaster";
public $dashboardTitle ="PayrollItemsMaster";
public $breadCrumbTitle ="PayrollItemsMaster";
public $idField ="PayrollItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PayrollItemID"];
public $gridFields = [

"PayrollItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PayrollItemDescription" => [
    "dbType" => "varchar(50)",
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
"YTDMaximum" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"Minimum" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"WageHigh" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"WageLow" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
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
],
"GLAccount" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

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
"GLAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccount2" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccount3" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
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
]
]];
public $columnNames = [

"PayrollItemID" => "Payroll Item ID",
"PayrollItemDescription" => "Payroll Item Description",
"Basis" => "Basis",
"PayrollItemTypeID" => "Payroll Item Type ID",
"YTDMaximum" => "YTD Maximum",
"Minimum" => "Minimum",
"WageHigh" => "Wage High",
"WageLow" => "Wage Low",
"ItemAmount" => "Item Amount",
"ItemPercent" => "Item Percent",
"PercentAmount" => "Percent Amount",
"TotalAmount" => "Total Amount",
"GLAccount" => "GL Account",
"ApplyItem" => "Apply Item",
"GLAccount2" => "GL Account 2",
"GLAccount3" => "GL Account 3",
"Employer" => "Employer",
"EmployerItemAmount" => "Employer Item Amount",
"EmployerItemPercent" => "Employer Item Percent",
"EmployerPercentAmount" => "Employer Percent Amount",
"EmployerTotalAmount" => "Employer Total Amount",
"DefaultItem" => "Default Item",
"Frm941Line2" => "Frm 941 Line 2",
"Frm941Line3" => "Frm 941 Line 3",
"Frm941Line4" => "Frm 941 Line 4",
"Frm941Line6a" => "Frm 941 Line 6a",
"Frm941Line6b" => "Frm 941 Line 6b",
"Frm941Line7" => "Frm 941 Line 7",
"Frm941Line9" => "Frm 941 Line 9",
"Frm941Line12" => "Frm 94 1Line 12",
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
"W2Box21" => "W2 Box 21"];
}?>
