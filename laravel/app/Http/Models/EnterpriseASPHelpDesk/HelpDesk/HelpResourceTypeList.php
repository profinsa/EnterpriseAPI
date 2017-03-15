<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpresourcetype";
public $dashboardTitle ="Help Resource Types";
public $breadCrumbTitle ="Help Resource Types";
public $idField ="ResourceType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ResourceType"];
public $gridFields = [

"ResourceType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ResourceTypeDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ResourceType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ResourceTypeDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ResourceType" => "Resource Type",
"ResourceTypeDescription" => "Resource Type Description"];
}?>
