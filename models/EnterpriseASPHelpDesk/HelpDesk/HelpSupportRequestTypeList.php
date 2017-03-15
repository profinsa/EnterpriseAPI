<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpsupportrequesttype";
public $dashboardTitle ="Support Request Types";
public $breadCrumbTitle ="Support Request Types";
public $idField ="SupportRequestType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","SupportRequestType"];
public $gridFields = [

"SupportRequestType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"SupportRequestTypeDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"SupportRequestType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupportRequestTypeDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"SupportRequestType" => "Support Request Type",
"SupportRequestTypeDescription" => "Support Request Type Description"];
}?>
