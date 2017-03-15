<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpproblemtype";
public $dashboardTitle ="Help Problem Types";
public $breadCrumbTitle ="Help Problem Types";
public $idField ="ProblemType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ProblemType"];
public $gridFields = [

"ProblemType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ProblemTypeDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ProblemType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProblemTypeDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ProblemType" => "Problem Type",
"ProblemTypeDescription" => "Problem Type Description"];
}?>
