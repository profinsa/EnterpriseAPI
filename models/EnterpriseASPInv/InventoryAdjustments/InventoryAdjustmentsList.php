<?php

/*
Name of Page: InvetoryAdjustmentsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\InventoryAdjustments\InvetoryAdjustmentsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InvetoryAdjustmentsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\InventoryAdjustments\InvetoryAdjustmentsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\InventoryAdjustments\InvetoryAdjustmentsList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryadjustments";
public $dashboardTitle ="Inventory Adjustments";
public $breadCrumbTitle ="Inventory Adjustments";
public $idField ="AdjustmentID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AdjustmentID"];
public $gridFields = [

"AdjustmentID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AdjustmentTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AdjustmentDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"AdjustmentReason" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"AdjustmentPosted" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"AdjustmentID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"SystemDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"AdjustmentReason" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentPosted" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"AdjustmentNotes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentPostToGL" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"BatchControlNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"BatchControlTotal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
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
"EnteredBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Signature" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SignaturePassword" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorSignature" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorPassword" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ManagerSignature" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ManagerPassword" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Total" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AdjustmentID" => "Adjustment ID",
"AdjustmentTypeID" => "Adjustment Type ID",
"AdjustmentDate" => "Adjustment Date",
"AdjustmentReason" => "Adjustment Reason",
"AdjustmentPosted" => "Adjustment Posted",
"SystemDate" => "System Date",
"AdjustmentNotes" => "Adjustment Notes",
"AdjustmentPostToGL" => "Adjustment Post To GL",
"BatchControlNumber" => "Batch Control Number",
"BatchControlTotal" => "Batch Control Total",
"Approved" => "Approved",
"ApprovedBy" => "Approved By",
"ApprovedDate" => "Approved Date",
"EnteredBy" => "Entered By",
"Signature" => "Signature",
"SignaturePassword" => "Signature Password",
"SupervisorSignature" => "Supervisor Signature",
"SupervisorPassword" => "Supervisor Password",
"ManagerSignature" => "Manager Signature",
"ManagerPassword" => "Manager Password",
"Total" => "Total"];
}?>
