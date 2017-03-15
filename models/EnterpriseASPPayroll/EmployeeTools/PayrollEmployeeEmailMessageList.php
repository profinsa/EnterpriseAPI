<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeeemailmessage";
public $dashboardTitle ="PayrollEmployeeEmailMessage";
public $breadCrumbTitle ="PayrollEmployeeEmailMessage";
public $idField ="EmailMessageID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmailMessageID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmailMessageID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CommunicationType" => [
    "dbType" => "varchar(12)",
    "inputType" => "text"
],
"Status" => [
    "dbType" => "varchar(12)",
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
"EmailMessageID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CommunicationType" => [
"dbType" => "varchar(12)",
"inputType" => "text",
"defaultValue" => ""
],
"Status" => [
"dbType" => "varchar(12)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"EmailMessageID" => "Message ID",
"CommunicationType" => "Communication Type",
"Status" => "Status"];
}?>
