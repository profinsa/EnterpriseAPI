<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helppriority";
public $dashboardTitle ="Help Priorities";
public $breadCrumbTitle ="Help Priorities";
public $idField ="Priority";
public $idFields = ["CompanyID","DivisionID","DepartmentID","Priority"];
public $gridFields = [

"Priority" => [
    "dbType" => "tinyint(3) unsigned",
    "inputType" => "text"
],
"PriorityDescription" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"Priority" => [
"dbType" => "tinyint(3) unsigned",
"inputType" => "text",
"defaultValue" => ""
],
"PriorityDescription" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"Priority" => "Priority",
"PriorityDescription" => "Priority Description"];
}?>
