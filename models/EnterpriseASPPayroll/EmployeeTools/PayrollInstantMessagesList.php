<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollinstantmessages";
public $dashboardTitle ="PayrollInstantMessages";
public $breadCrumbTitle ="PayrollInstantMessages";
public $idField ="InstantMessageID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","InstantMessageID"];
public $gridFields = [

"InstantMessageID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"InstantMessageText" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
],
"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeEmail" => [
    "dbType" => "varchar(60)",
    "inputType" => "text"
],
"TimeSent" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"InstantMessageID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"InstantMessageText" => [
"dbType" => "varchar(255)",
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
],
"TimeSent" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"InstantMessageID" => "Message ID",
"InstantMessageText" => "Message Text",
"EmployeeID" => "Employee ID",
"EmployeeEmail" => "Employee Email",
"TimeSent" => "Time Sent"];
}?>
