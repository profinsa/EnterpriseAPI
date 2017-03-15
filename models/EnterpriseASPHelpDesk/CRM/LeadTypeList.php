<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "leadtype";
public $dashboardTitle ="Lead Type";
public $breadCrumbTitle ="Lead Type";
public $idField ="LeadTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","LeadTypeID"];
public $gridFields = [

"LeadTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"LeadTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"LeadTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"LeadTypeID" => "Lead Type ID",
"LeadTypeDescription" => "Lead Type Description"];
}?>
