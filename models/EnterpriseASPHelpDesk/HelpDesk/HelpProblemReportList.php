<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpproblemreport";
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
"inputType" => "text",
"defaultValue" => ""
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
"inputType" => "text",
"defaultValue" => ""
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
"inputType" => "text",
"defaultValue" => ""
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
"ProblemManager" => "ProblemManager",
"ProblemAssigned" => "ProblemAssigned",
"ProblemAssignedTo" => "ProblemAssignedTo",
"ProblemRequestMethod" => "ProblemRequestMethod",
"ProblemStatus" => "ProblemStatus",
"ProblemPriority" => "ProblemPriority",
"ProblemVersion" => "ProblemVersion",
"ProblemDate" => "ProblemDate",
"ProblemKeywords" => "ProblemKeywords",
"ProblemLongDescription" => "ProblemLongDescription",
"ProblemExactErrorMessage" => "ProblemExactErrorMessage",
"ProblemStepsToReproduce" => "ProblemStepsToReproduce",
"ProblemScreenShotURL" => "ProblemScreenShotURL",
"ProblemFixed" => "ProblemFixed",
"ProblemFixDate" => "ProblemFixDate",
"ProblemFix" => "ProblemFix",
"ProblemTimeSpentFixing" => "ProblemTimeSpentFixing",
"ProblemNotesPrivate" => "ProblemNotesPrivate",
"ProblemApproved" => "ProblemApproved",
"ProblemApprovedBy" => "ProblemApprovedBy"];
}?>
