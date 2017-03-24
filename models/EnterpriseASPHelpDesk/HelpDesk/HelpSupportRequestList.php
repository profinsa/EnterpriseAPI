<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpsupportrequest";
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
"SupportManager" => "SupportManager",
"SupportAssigned" => "SupportAssigned",
"SupportAssignedTo" => "SupportAssignedTo",
"SupportRequestMethod" => "SupportRequestMethod",
"SupportStatus" => "SupportStatus",
"SupportPriority" => "SupportPriority",
"SupportType" => "SupportType",
"SupportVersion" => "SupportVersion",
"SupportDate" => "SupportDate",
"SupportKeywords" => "SupportKeywords",
"SupportDescription" => "SupportDescription",
"SupportScreenShotURL" => "SupportScreenShotURL",
"SupportResolution" => "SupportResolution",
"SupportResolutionDate" => "SupportResolutionDate",
"SupportTimeSpentFixing" => "SupportTimeSpentFixing",
"SuportNotesPrivate" => "SuportNotesPrivate",
"SupportApproved" => "SupportApproved",
"SupportApprovedBy" => "SupportApprovedBy"];
}?>
