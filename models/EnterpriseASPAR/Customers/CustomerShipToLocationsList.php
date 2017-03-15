<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customershiptolocations";
public $dashboardTitle ="Customer Ship To Locations";
public $breadCrumbTitle ="Customer Ship To Locations";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ShipToID"];
public $gridFields = [

"CustomerID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ShipToID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ShipToName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ShipToAttention" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"CustomerID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToAddress3" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToZip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToCountry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToEmail" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToWebPage" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToAttention" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToNotes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"ShipToID" => "Ship To ID",
"ShipToName" => "Ship To Name",
"ShipToAttention" => "Ship To Attention",
"ShipToAddress1" => "ShipToAddress1",
"ShipToAddress2" => "ShipToAddress2",
"ShipToAddress3" => "ShipToAddress3",
"ShipToCity" => "ShipToCity",
"ShipToState" => "ShipToState",
"ShipToZip" => "ShipToZip",
"ShipToCountry" => "ShipToCountry",
"ShipToEmail" => "ShipToEmail",
"ShipToWebPage" => "ShipToWebPage",
"ShipToNotes" => "ShipToNotes"];
}?>
