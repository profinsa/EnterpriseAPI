<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpnewsboard";
public $dashboardTitle ="Help News Board";
public $breadCrumbTitle ="Help News Board";
public $idField ="NewsId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","NewsId"];
public $gridFields = [

"NewsId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"NewsProductId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"NewsTitle" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"NewsDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"NewsMessage" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"NewsId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"NewsProductId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"NewsTitle" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"NewsDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"NewsMessage" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"NewsId" => "News Id",
"NewsProductId" => "ProductI d",
"NewsTitle" => "Title",
"NewsDate" => "Date",
"NewsMessage" => "Message"];
}?>
