<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpsupportrequesttype";
protected $gridFields =["SupportRequestType","SupportRequestTypeDescription"];
public $dashboardTitle ="Support Request Types";
public $breadCrumbTitle ="Support Request Types";
public $idField ="SupportRequestType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","SupportRequestType"];
public $editCategories = [
"Main" => [

"SupportRequestType" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupportRequestTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"SupportRequestType" => "Support Request Type",
"SupportRequestTypeDescription" => "Support Request Type Description"];
}?>
