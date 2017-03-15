<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestaskheader";
protected $gridFields =["TaskTypeID","StartDate","DueDate","CompletedDate","PriorityID","LeadID","CustomerID","VendorID"];
public $dashboardTitle ="Payroll Employees Tasks";
public $breadCrumbTitle ="Payroll Employees Tasks";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","EmployeeTaskID"];
public $editCategories = [
"Main" => [

"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeTaskID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaskTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"StartDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"DueDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"Completed" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompletedDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"PriorityID" => [
"inputType" => "text",
"defaultValue" => ""
],
"RelatedDocumentType" => [
"inputType" => "text",
"defaultValue" => ""
],
"RelatedDocumentNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorID" => [
"inputType" => "text",
"defaultValue" => ""
],
"Description" => [
"inputType" => "text",
"defaultValue" => ""
],
"DelegatedTo" => [
"inputType" => "text",
"defaultValue" => ""
],
"DelegatedDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
]
]];
public $columnNames = [

"TaskTypeID" => "Task Type ID",
"StartDate" => "Start Date",
"DueDate" => "Due Date",
"CompletedDate" => "Completed Date",
"PriorityID" => "Priority ID",
"LeadID" => "Lead ID",
"CustomerID" => "Customer ID",
"VendorID" => "Vendor ID",
"EmployeeID" => "EmployeeID",
"EmployeeTaskID" => "EmployeeTaskID",
"Completed" => "Completed",
"RelatedDocumentType" => "RelatedDocumentType",
"RelatedDocumentNumber" => "RelatedDocumentNumber",
"Description" => "Description",
"DelegatedTo" => "DelegatedTo",
"DelegatedDate" => "DelegatedDate"];
}?>
