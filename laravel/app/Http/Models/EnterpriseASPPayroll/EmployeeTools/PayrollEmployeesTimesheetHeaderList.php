<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
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
"inputType" => "datetime",
"defaultValue" => "now"
],
"PeriodEnd" => [
"inputType" => "datetime",
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
"inputType" => "datetime",
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
