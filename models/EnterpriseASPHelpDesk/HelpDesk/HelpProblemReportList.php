<?php

/*
Name of Page: HelpProblemReportList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpProblemReportList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/HelpProblemReportList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpProblemReportList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\HelpDesk\HelpProblemReportList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class HelpProblemReportList extends gridDataSource{
public $tableName = "helpproblemreport";
public $dashboardTitle ="Help Problem Reports";
public $breadCrumbTitle ="Help Problem Reports";
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
"ProductId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ProblemType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ProblemShortDescription" => [
    "dbType" => "varchar(80)",
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
"ProductId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemManager" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemAssigned" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ProblemAssignedTo" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemRequestMethod" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemStatus" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemPriority" => [
"dbType" => "tinyint(3) unsigned",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemVersion" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ProblemShortDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemKeywords" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemLongDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemExactErrorMessage" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemStepsToReproduce" => [
"dbType" => "varchar(999)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemScreenShotURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemFixed" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ProblemFixDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ProblemFix" => [
"dbType" => "varchar(999)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemTimeSpentFixing" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemNotesPrivate" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemApproved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ProblemApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CaseId" => "Case Id",
"CustomerId" => "Customer Id",
"ProductId" => "Product Id",
"ProblemType" => "Type",
"ProblemShortDescription" => "Short Description",
"ProblemManager" => "Problem Manager",
"ProblemAssigned" => "Problem Assigned",
"ProblemAssignedTo" => "Problem Assigned To",
"ProblemRequestMethod" => "Problem Request Method",
"ProblemStatus" => "Problem Status",
"ProblemPriority" => "Problem Priority",
"ProblemVersion" => "Problem Version",
"ProblemDate" => "Problem Date",
"ProblemKeywords" => "Problem Keywords",
"ProblemLongDescription" => "Problem Long Description",
"ProblemExactErrorMessage" => "Problem Exact Error Message",
"ProblemStepsToReproduce" => "Problem Steps To Reproduce",
"ProblemScreenShotURL" => "Problem Screen Shot URL",
"ProblemFixed" => "Problem Fixed",
"ProblemFixDate" => "Problem Fix Date",
"ProblemFix" => "Problem Fix",
"ProblemTimeSpentFixing" => "Problem Time Spent Fixing",
"ProblemNotesPrivate" => "Problem Notes Private",
"ProblemApproved" => "Problem Approved",
"ProblemApprovedBy" => "Problem Approved By"];
}?>
