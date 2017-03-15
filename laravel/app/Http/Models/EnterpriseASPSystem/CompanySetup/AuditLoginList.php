<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "auditlogin";
public $dashboardTitle ="Audit Logins";
public $breadCrumbTitle ="Audit Logins";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","AuditID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AuditID" => [
    "dbType" => "bigint(20)",
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
"dbType" => "bigint(20)",
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
"AuditID" => "AuditID",
"LoginDateTime" => "Login Date Time",
"MachineName" => "Machine Name",
"IPAddress" => "IP Address",
"LoginType" => "Login Type"];
}?>
