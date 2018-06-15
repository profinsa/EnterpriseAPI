<?php

/*
Name of Page: HelpSupportRequestList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpSupportRequestList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/HelpSupportRequestList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpSupportRequestList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpSupportRequestList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "helpsupportrequest";
public $dashboardTitle ="Help Support Requests";
public $breadCrumbTitle ="Help Support Requests";
public $idField ="CaseId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CaseId"];
public $gridFields = [

"CaseId" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"CustomerId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ProductId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"SupportQuestion" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"CaseId" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"CustomerId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProductId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportManager" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportAssigned" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"SupportAssignedTo" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportRequestMethod" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportStatus" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportPriority" => [
"dbType" => "tinyint(3) unsigned",
"inputType" => "text",
"defaultValue" => ""
],
"SupportType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportVersion" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"SupportQuestion" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportKeywords" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportDescription" => [
"dbType" => "varchar(999)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportScreenShotURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportResolution" => [
"dbType" => "varchar(999)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportResolutionDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"SupportTimeSpentFixing" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"SuportNotesPrivate" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportApproved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"SupportApprovedBy" => [
"dbType" => "varchar(26)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CaseId" => "Case Id",
"CustomerId" => "Customer Id",
"ContactId" => "Contact Id",
"ProductId" => "Product Id",
"SupportQuestion" => "Question",
"SupportManager" => "Support Manager",
"SupportAssigned" => "Support Assigned",
"SupportAssignedTo" => "Support Assigned To",
"SupportRequestMethod" => "Support Request Method",
"SupportStatus" => "Support Status",
"SupportPriority" => "Support Priority",
"SupportType" => "Support Type",
"SupportVersion" => "Support Version",
"SupportDate" => "Support Date",
"SupportKeywords" => "Support Keywords",
"SupportDescription" => "Support Description",
"SupportScreenShotURL" => "Support Screen Shot URL",
"SupportResolution" => "Support Resolution",
"SupportResolutionDate" => "Support Resolution Date",
"SupportTimeSpentFixing" => "Support Time Spent Fixing",
"SuportNotesPrivate" => "Suport Notes Private",
"SupportApproved" => "Support Approved",
"SupportApprovedBy" => "Support Approved By"];
}?>
