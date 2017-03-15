<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestimesheetheader";
protected $gridFields =["EmployeeID","TimePeriod","PeriodStart","PeriodEnd","ApprovedBy","ApprovedDate"];
public $dashboardTitle ="PayrollEmployeesTimesheetHeader";
public $breadCrumbTitle ="PayrollEmployeesTimesheetHeader";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","TimePeriod"];
public $editCategories = [
"Main" => [

"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TimePeriod" => [
"inputType" => "text",
"defaultValue" => ""
],
"PeriodStart" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"PeriodEnd" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"Notes" => [
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"Processed" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProcessedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProcessedDate" => [
"inputType" => "datepicker",
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
