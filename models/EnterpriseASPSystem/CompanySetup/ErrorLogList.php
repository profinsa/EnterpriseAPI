<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "errorlog";
public $gridFields =["EmployeeID","ErrorDate","ErrorTime","ErrorCode","ErrorMessage"];
public $dashboardTitle ="Error Log";
public $breadCrumbTitle ="Error Log";
public $idField ="ErrorID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ErrorID"];
public $editCategories = [
"Main" => [

"ErrorID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ErrorDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ErrorTime" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ScreenName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ModuleName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ErrorCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"ErrorMessage" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProcedureName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CallTime" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Error" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"ErrorDate" => "Error Date",
"ErrorTime" => "Error Time",
"ErrorCode" => "Error Code",
"ErrorMessage" => "Error Message",
"ErrorID" => "ErrorID",
"ScreenName" => "ScreenName",
"ModuleName" => "ModuleName",
"ProcedureName" => "ProcedureName",
"CallTime" => "CallTime",
"Error" => "Error"];
}?>
