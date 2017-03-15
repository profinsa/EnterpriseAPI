<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpstatus";
public $dashboardTitle ="Help Statuses";
public $breadCrumbTitle ="Help Statuses";
public $idField ="StatusId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","StatusId"];
public $gridFields = [

"StatusId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"StatusDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"StatusId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"StatusDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"StatusId" => "Status Id",
"StatusDescription" => "Status Description"];
}?>
