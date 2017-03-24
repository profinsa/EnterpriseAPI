<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestimesheetheader";
public $dashboardTitle ="PayrollEmployeesTimesheetHeader";
public $breadCrumbTitle ="PayrollEmployeesTimesheetHeader";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","TimePeriod"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TimePeriod" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PeriodStart" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"PeriodEnd" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"ApprovedBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ApprovedDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TimePeriod" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PeriodStart" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PeriodEnd" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Notes" => [
"dbType" => "varchar(255)",
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
"Processed" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ProcessedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProcessedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"TimePeriod" => "Time Period",
"PeriodStart" => "Period Start",
"PeriodEnd" => "Period End",
"ApprovedBy" => "Approved By",
"ApprovedDate" => "Approved Date",
"Notes" => "Notes",
"Approved" => "Approved",
"Processed" => "Processed",
"ProcessedBy" => "ProcessedBy",
"ProcessedDate" => "ProcessedDate"];
}?>
