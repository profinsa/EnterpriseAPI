<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpreleasedates";
public $dashboardTitle ="Help Release Dates";
public $breadCrumbTitle ="Help Release Dates";
public $idField ="ProductName";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ProductName","CurrentVersion"];
public $gridFields = [

"ProductName" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CurrentVersion" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"NextVersion" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"ReleaseDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"Notes" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ProductName" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrentVersion" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"NextVersion" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ReleaseDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Notes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ProductName" => "Product Name",
"CurrentVersion" => "Current Version",
"NextVersion" => "Next Version",
"ReleaseDate" => "Release Date",
"Notes" => "Notes"];
}?>
