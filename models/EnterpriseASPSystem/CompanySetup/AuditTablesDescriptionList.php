<?php

/*
Name of Page: AuditTablesDescriptionList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditTablesDescriptionList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/AuditTablesDescriptionList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditTablesDescriptionList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditTablesDescriptionList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "audittablesdescription";
public $dashboardTitle ="AuditTablesDescription";
public $breadCrumbTitle ="AuditTablesDescription";
public $idField ="undefined";
public $idFields = ["TableName"];
public $gridFields = [

"TableName" => [
    "dbType" => "varchar(128)",
    "inputType" => "text"
],
"DocumentType" => [
    "dbType" => "varchar(128)",
    "inputType" => "text"
],
"TransactionNumberField" => [
    "dbType" => "varchar(128)",
    "inputType" => "text"
],
"TransactionLineNumberField" => [
    "dbType" => "varchar(128)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TableName" => [
"dbType" => "varchar(128)",
"inputType" => "text",
"defaultValue" => ""
],
"DocumentType" => [
"dbType" => "varchar(128)",
"inputType" => "text",
"defaultValue" => ""
],
"TransactionNumberField" => [
"dbType" => "varchar(128)",
"inputType" => "text",
"defaultValue" => ""
],
"TransactionLineNumberField" => [
"dbType" => "varchar(128)",
"inputType" => "text",
"defaultValue" => ""
],
"ComplexObject" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApplyAudit" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
]
]];
public $columnNames = [

"TableName" => "Table Name",
"DocumentType" => "Document Type",
"TransactionNumberField" => "Transaction Number Field",
"TransactionLineNumberField" => "Transaction LineNumber Field",
"ComplexObject" => "Complex Object",
"ApplyAudit" => "Apply Audit"];
}?>
