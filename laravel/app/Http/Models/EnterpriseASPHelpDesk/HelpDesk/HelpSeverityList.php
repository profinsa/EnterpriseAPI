<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpseverity";
public $dashboardTitle ="Help Severities";
public $breadCrumbTitle ="Help Severities";
public $idField ="Severity";
public $idFields = ["CompanyID","DivisionID","DepartmentID","Severity"];
public $gridFields = [

"Severity" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"SeverityDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"Severity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"SeverityDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"Severity" => "Severity",
"SeverityDescription" => "Severity Description"];
}?>
