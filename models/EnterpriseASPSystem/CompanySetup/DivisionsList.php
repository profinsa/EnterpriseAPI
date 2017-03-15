<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "divisions";
public $dashboardTitle ="Divisions";
public $breadCrumbTitle ="Divisions";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $gridFields = [

"DivisionName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"DivisionDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"DivisionPhone" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"DivisionName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DivisionDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DivisionAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DivisionAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DivisionCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DivisionState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DivisionZip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"DivisionCountry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DivisionPhone" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"DivisionFax" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"DivisionEmail" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"DivisionWebAddress" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"DivisionNotes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"DivisionID" => "Division ID",
"DivisionName" => "Division Name",
"DivisionDescription" => "Division Description",
"DivisionPhone" => "Division Phone",
"DivisionAddress1" => "DivisionAddress1",
"DivisionAddress2" => "DivisionAddress2",
"DivisionCity" => "DivisionCity",
"DivisionState" => "DivisionState",
"DivisionZip" => "DivisionZip",
"DivisionCountry" => "DivisionCountry",
"DivisionFax" => "DivisionFax",
"DivisionEmail" => "DivisionEmail",
"DivisionWebAddress" => "DivisionWebAddress",
"DivisionNotes" => "DivisionNotes"];
}?>
