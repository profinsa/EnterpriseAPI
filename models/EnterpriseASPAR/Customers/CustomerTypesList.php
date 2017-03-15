<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customertypes";
public $dashboardTitle ="Customer Types";
public $breadCrumbTitle ="Customer Types";
public $idField ="CustomerTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerTypeID"];
public $gridFields = [

"CustomerTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CustomerTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"CustomerTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CustomerTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerTypeID" => "Customer Type ID",
"CustomerTypeDescription" => "Customer Type Description"];
}?>
