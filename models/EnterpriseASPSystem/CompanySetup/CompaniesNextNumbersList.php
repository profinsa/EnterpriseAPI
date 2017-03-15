<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companiesnextnumbers";
public $gridFields =[];
public $dashboardTitle ="CompaniesNextNumbers";
public $breadCrumbTitle ="CompaniesNextNumbers";
public $idField ="NextNumberName";
public $idFields = ["CompanyID","DivisionID","DepartmentID","NextNumberName"];
public $editCategories = [
"Main" => [

"NextNumberName" => [
"inputType" => "text",
"defaultValue" => ""
],
"NextNumberValue" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"NextNumberName" => "NextNumberName",
"NextNumberValue" => "NextNumberValue"];
}?>
