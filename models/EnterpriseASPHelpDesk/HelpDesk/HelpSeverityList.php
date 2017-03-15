<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpseverity";
protected $gridFields =["Severity","SeverityDescription"];
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
