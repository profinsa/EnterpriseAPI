<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpproblemreport";
protected $gridFields =["CaseId","CustomerId","ProductId","ProblemType","ProblemShortDescription"];
public $dashboardTitle ="Help Problem Reports";
public $breadCrumbTitle ="Help Problem Reports";
public $idField ="CaseId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CaseId"];
public $editCategories = [
"Main" => [

"CaseId" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerId" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProductId" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemManager" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemAssigned" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemAssignedTo" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemRequestMethod" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemStatus" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemPriority" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemType" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemVersion" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ProblemShortDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemKeywords" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemLongDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemExactErrorMessage" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemStepsToReproduce" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemScreenShotURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemFixed" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemFixDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ProblemFix" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemTimeSpentFixing" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemNotesPrivate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemApproved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemApprovedBy" => [
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
