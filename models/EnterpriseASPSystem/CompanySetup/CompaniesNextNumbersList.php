<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companiesnextnumbers";
public $dashboardTitle ="CompaniesNextNumbers";
public $breadCrumbTitle ="CompaniesNextNumbers";
public $idField ="NextNumberName";
public $idFields = ["CompanyID","DivisionID","DepartmentID","NextNumberName"];
public $gridFields = [
];

public $editCategories = [
"Main" => [

"NextNumberName" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"NextNumberValue" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"NextNumberName" => "NextNumberName",
"NextNumberValue" => "NextNumberValue"];
}?>
