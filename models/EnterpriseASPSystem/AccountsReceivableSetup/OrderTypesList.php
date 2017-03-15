<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ordertypes";
public $dashboardTitle ="Order Types";
public $breadCrumbTitle ="Order Types";
public $idField ="OrderTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","OrderTypeID"];
public $gridFields = [

"OrderTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"OrderTypeDescription" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"OrderTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"OrderTypeDescription" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"OrderTypeID" => "Order Type ID",
"OrderTypeDescription" => "Order Type Description"];
}?>
