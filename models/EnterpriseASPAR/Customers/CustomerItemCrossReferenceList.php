<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customeritemcrossreference";
public $dashboardTitle ="Customer Item Cross Reference";
public $breadCrumbTitle ="Customer Item Cross Reference";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","CustomerItemID"];
public $gridFields = [

"CustomerID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CustomerItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CustomerItemDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ItemDescription" => [
    "dbType" => "varchar(80)",
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
"CustomerItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CustomerItemDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"CustomerItemID" => "Customer Item ID",
"CustomerItemDescription" => "Customer Item Description",
"ItemID" => "Item ID",
"ItemDescription" => "Item Description"];
}?>
