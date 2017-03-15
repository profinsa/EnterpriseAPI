<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpsupportrequest";
public $gridFields =["CaseId","CustomerId","ContactId","ProductId","SupportQuestion"];
public $dashboardTitle ="Help Support Requests";
public $breadCrumbTitle ="Help Support Requests";
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
"ContactId" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProductId" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportManager" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportAssigned" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportAssignedTo" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportRequestMethod" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportStatus" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportPriority" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportType" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportVersion" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"SupportQuestion" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportKeywords" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportScreenShotURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportResolution" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportResolutionDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"SupportTimeSpentFixing" => [
"inputType" => "text",
"defaultValue" => ""
],
"SuportNotesPrivate" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportApproved" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportApprovedBy" => [
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
