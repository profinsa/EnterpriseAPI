<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeesevents";
public $dashboardTitle ="PayrollEmployeesEvents";
public $breadCrumbTitle ="PayrollEmployeesEvents";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","EventDate","EventID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EventDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"EventID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EventTime" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"EventTimeUnits" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"Reason" => [
    "dbType" => "varchar(80)",
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
"EventDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EventID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EventTime" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"EventTimeUnits" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"Description" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
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
