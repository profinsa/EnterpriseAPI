<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeeinstantmessage";
public $dashboardTitle ="PayrollEmployeeInstantMessage";
public $breadCrumbTitle ="PayrollEmployeeInstantMessage";
public $idField ="InstantMessageID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","InstantMessageID"];
public $gridFields = [

"InstantMessageID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeEmail" => [
    "dbType" => "varchar(60)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"InstantMessageID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeEmail" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"InstantMessageID" => "Message ID",
"EmployeeID" => "Employee ID",
"EmployeeEmail" => "Employee Email"];
}?>
