<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helprequestmethod";
public $dashboardTitle ="Help Request Methods";
public $breadCrumbTitle ="Help Request Methods";
public $idField ="RequestMethod";
public $idFields = ["CompanyID","DivisionID","DepartmentID","RequestMethod"];
public $gridFields = [

"RequestMethod" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"RequestMethodDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"RequestMethod" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RequestMethodDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"RequestMethod" => "Request Method",
"RequestMethodDescription" => "Request Method Description"];
}?>
