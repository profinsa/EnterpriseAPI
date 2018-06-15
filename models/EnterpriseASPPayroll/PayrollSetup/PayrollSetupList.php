<?php

/*
Name of Page: PayrollSetupList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollSetupList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollSetupList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollSetupList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollSetupList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "payrollsetup";
public $dashboardTitle ="PayrollSetup";
public $breadCrumbTitle ="PayrollSetup";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $gridFields = [

"FederalTaxIDNumber" => [
    "dbType" => "varchar(15)",
    "inputType" => "text"
],
"StateTaxIDNumber" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CountyTaxIDNumber" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"GLPayrollCashAccount" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"FederalTaxIDNumber" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"State" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"StateTaxIDNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"County" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CountyTaxIDNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CityName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CityTaxIDNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"FITRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FITWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FICARate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FICAEmployerPortion" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FICAWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FUTARate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FUTAWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SUTARate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SUTAWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SITRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SITWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SDIRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SDIWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SSIRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SSIWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FICAMedRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FICAMedWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CreatePayroll" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"PayCommissions" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"OTAfter" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFITPayrollAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFITExpenseAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFICAPayrollAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFICAExpenseAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFUTAPayrollAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFUTAExpenseAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLSUTAPayrollAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLSUTAExpenseAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLSITPayrollAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLSITExpenseAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLSDIPayrollAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLSDIExpenseAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFICAMedPayrollAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFICAMedExpenseAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPayrollCashAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLLocalPayrollAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLSalesPayrollExpenseAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLOfficePayrollExpenseAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLWarehousePayrollExpenseAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLProductionPayrollExpenseAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLOvertimePayrollExpenseAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLWagesPayrollAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPayrollTaxExpenseAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBonusPayrollAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"FederalTaxIDNumber" => "Federal Tax ID Number",
"StateTaxIDNumber" => "State Tax ID Number",
"CountyTaxIDNumber" => "County Tax ID Number",
"GLPayrollCashAccount" => "GL Payroll Cash Account",
"State" => "State",
"County" => "County",
"CityName" => "CityName",
"CityTaxIDNumber" => "CityTaxIDNumber",
"FITRate" => "FITRate",
"FITWageBase" => "FITWageBase",
"FICARate" => "FICARate",
"FICAEmployerPortion" => "FICAEmployerPortion",
"FICAWageBase" => "FICAWageBase",
"FUTARate" => "FUTARate",
"FUTAWageBase" => "FUTAWageBase",
"SUTARate" => "SUTARate",
"SUTAWageBase" => "SUTAWageBase",
"SITRate" => "SITRate",
"SITWageBase" => "SITWageBase",
"SDIRate" => "SDIRate",
"SDIWageBase" => "SDIWageBase",
"SSIRate" => "SSIRate",
"SSIWageBase" => "SSIWageBase",
"FICAMedRate" => "FICAMedRate",
"FICAMedWageBase" => "FICAMedWageBase",
"CreatePayroll" => "CreatePayroll",
"PayCommissions" => "PayCommissions",
"OTAfter" => "OTAfter",
"GLFITPayrollAccount" => "GLFIT Payroll Account",
"GLFITExpenseAccount" => "GLFIT Expense Account",
"GLFICAPayrollAccount" => "GLFICA Payroll Account",
"GLFICAExpenseAccount" => "GLFICA Expense Account",
"GLFUTAPayrollAccount" => "GLFUTA Payroll Account",
"GLFUTAExpenseAccount" => "GLFUTA Expense Account",
"GLSUTAPayrollAccount" => "GLSUTA Payroll Account",
"GLSUTAExpenseAccount" => "GLSUTA Expense Account",
"GLSITPayrollAccount" => "GLSIT Payroll Account",
"GLSITExpenseAccount" => "GLSIT Expense Account",
"GLSDIPayrollAccount" => "GLSDI Payroll Account",
"GLSDIExpenseAccount" => "GLSDI Expense Account",
"GLFICAMedPayrollAccount" => "GLFICA Med Payroll Account",
"GLFICAMedExpenseAccount" => "GLFICA Med Expense Account",
"GLLocalPayrollAccount" => "GL Local Payroll Account",
"GLSalesPayrollExpenseAccount" => "GL Sales Payroll Expense Account",
"GLOfficePayrollExpenseAccount" => "GL Office Payroll Expense Account",
"GLWarehousePayrollExpenseAccount" => "GL Warehouse Payroll ExpenseAccount",
"GLProductionPayrollExpenseAccount" => "GL Production Payroll ExpenseAccount",
"GLOvertimePayrollExpenseAccount" => "GL Overtime Payroll ExpenseAccount",
"GLWagesPayrollAccount" => "GL Wages Payroll Account",
"GLPayrollTaxExpenseAccount" => "GL Payroll Tax Expense Account",
"GLBonusPayrollAccount" => "GL Bonus Payroll Account"];
}?>
