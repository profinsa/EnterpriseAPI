<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "auditloginhistory";
protected $gridFields =["EmployeeID","AuditID","LoginDateTime","MachineName","IPAddress","LoginType"];
public $dashboardTitle ="Audit Logins History";
public $breadCrumbTitle ="Audit Logins History";
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
"AuditID" => "Audit ID",
"LoginDateTime" => "Login DateTime",
"MachineName" => "Machine Name",
"IPAddress" => "IP Address",
"LoginType" => "Login Type"];
}?>
