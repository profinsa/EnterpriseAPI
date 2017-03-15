<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "timeunits";
public $dashboardTitle ="TimeUnits";
public $breadCrumbTitle ="TimeUnits";
public $idField ="TimeUnitID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TimeUnitID"];
public $gridFields = [

"TimeUnitID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TimeUnitDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TimeUnitID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TimeUnitDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"TimeUnitID" => "Time Unit ID",
"TimeUnitDescription" => "Time Unit Description"];
}?>
