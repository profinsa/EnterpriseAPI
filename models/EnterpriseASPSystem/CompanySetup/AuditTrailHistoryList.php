<?php

/*
Name of Page: AuditTrailHistoryList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditTrailHistoryList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/AuditTrailHistoryList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditTrailHistoryList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditTrailHistoryList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "audittrailhistory";
public $dashboardTitle ="Audit Trail History";
public $breadCrumbTitle ="Audit Trail History";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","AuditID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AuditID" => [
    "dbType" => "bigint(20)",
    "inputType" => "text"
],
"EntryDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"EntryTime" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"DocumentType" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TransactionNumber" => [
    "dbType" => "varchar(50)",
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
"AuditID" => [
"dbType" => "bigint(20)",
"inputType" => "text",
"defaultValue" => ""
],
"EntryDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EntryTime" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"DocumentType" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TransactionNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TableAffected" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"FieldChanged" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"OldValue" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"NewValue" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"TransactionLineNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"AuditID" => "Audit ID",
"EntryDate" => "Entry Date",
"EntryTime" => "Entry Time",
"DocumentType" => "Document Type",
"TransactionNumber" => "Transaction Number",
"TableAffected" => "Table Affected",
"FieldChanged" => "Field Changed",
"OldValue" => "Old Value",
"NewValue" => "New Value",
"TransactionLineNumber" => "Transaction Line Number"];
}?>
