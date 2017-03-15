<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "auditlogin";
protected $gridFields =["EmployeeID","AuditID","LoginDateTime","MachineName","IPAddress","LoginType"];
public $dashboardTitle ="Audit Logins";
public $breadCrumbTitle ="Audit Logins";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","AuditID"];
public $editCategories = [
"Main" => [

"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AuditID" => [
"inputType" => "text",
"defaultValue" => ""
],
"LoginDateTime" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"MachineName" => [
"inputType" => "text",
"defaultValue" => ""
],
"IPAddress" => [
"inputType" => "text",
"defaultValue" => ""
],
"LoginType" => [
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
