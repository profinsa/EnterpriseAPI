<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeesevents";
protected $gridFields =["EmployeeID","EventDate","EventID","EventTime","EventTimeUnits","Reason"];
public $dashboardTitle ="PayrollEmployeesEvents";
public $breadCrumbTitle ="PayrollEmployeesEvents";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","EventDate","EventID"];
public $editCategories = [
"Main" => [

"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EventDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"EventID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EventTime" => [
"inputType" => "text",
"defaultValue" => ""
],
"EventTimeUnits" => [
"inputType" => "text",
"defaultValue" => ""
],
"Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"Description" => [
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
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"EventDate" => "Event Date",
"EventID" => "Event ID",
"EventTime" => "Event Time",
"EventTimeUnits" => "Event Time Units",
"Reason" => "Reason",
"Description" => "Description",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate"];
}?>
