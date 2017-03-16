<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestaskheader";
public $dashboardTitle ="Payroll Employees Tasks";
public $breadCrumbTitle ="Payroll Employees Tasks";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","EmployeeTaskID"];
public $gridFields = [

"TaskTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"StartDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"DueDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"CompletedDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"PriorityID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"LeadID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CustomerID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"VendorID" => [
    "dbType" => "varchar(36)",
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
"EmployeeTaskID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaskTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"StartDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"DueDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Completed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"CompletedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PriorityID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedDocumentType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedDocumentNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CustomerID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"VendorID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Description" => [
"dbType" => "varchar(200)",
"inputType" => "text",
"defaultValue" => ""
],
"DelegatedTo" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"DelegatedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
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
