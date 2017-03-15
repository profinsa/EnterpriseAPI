<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeeemailmessage";
public $gridFields =["EmployeeID","EmailMessageID","CommunicationType","Status"];
public $dashboardTitle ="PayrollEmployeeEmailMessage";
public $breadCrumbTitle ="PayrollEmployeeEmailMessage";
public $idField ="EmailMessageID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmailMessageID"];
public $editCategories = [
"Main" => [

"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmailMessageID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommunicationType" => [
"inputType" => "text",
"defaultValue" => ""
],
"Status" => [
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
