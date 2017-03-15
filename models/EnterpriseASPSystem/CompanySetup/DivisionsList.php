<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "divisions";
public $gridFields =["DivisionID","DivisionName","DivisionDescription","DivisionPhone"];
public $dashboardTitle ="Divisions";
public $breadCrumbTitle ="Divisions";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $editCategories = [
"Main" => [

"DivisionName" => [
"inputType" => "text",
"defaultValue" => ""
],
"DivisionDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"DivisionAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"DivisionAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"DivisionCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"DivisionState" => [
"inputType" => "text",
"defaultValue" => ""
],
"DivisionZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"DivisionCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"DivisionPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"DivisionFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"DivisionEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"DivisionWebAddress" => [
"inputType" => "text",
"defaultValue" => ""
],
"DivisionNotes" => [
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
