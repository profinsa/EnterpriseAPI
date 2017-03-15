<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "auditloginhistory";
public $dashboardTitle ="Audit Logins History";
public $breadCrumbTitle ="Audit Logins History";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","AuditID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AuditID" => [
    "dbType" => "decimal(24,0)",
    "inputType" => "text"
],
"LoginDateTime" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"MachineName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"IPAddress" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"LoginType" => [
    "dbType" => "int(11)",
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
"AuditID" => [
"dbType" => "decimal(24,0)",
"inputType" => "text",
"defaultValue" => ""
],
"LoginDateTime" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"MachineName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"IPAddress" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LoginType" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"AuditID" => "Audit ID",
"LoginDateTime" => "Login DateTime",
"MachineName" => "Machine Name",
"IPAddress" => "IP Address",
"LoginType" => "Login Type"];
}?>
