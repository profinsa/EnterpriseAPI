<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpseverity";
public $gridFields =["Severity","SeverityDescription"];
public $dashboardTitle ="Help Severities";
public $breadCrumbTitle ="Help Severities";
public $idField ="Severity";
public $idFields = ["CompanyID","DivisionID","DepartmentID","Severity"];
public $editCategories = [
"Main" => [

"Severity" => [
"inputType" => "text",
"defaultValue" => ""
],
"SeverityDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"Severity" => "Severity",
"SeverityDescription" => "Severity Description"];
}?>
