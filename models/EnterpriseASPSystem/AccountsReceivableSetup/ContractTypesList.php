<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contracttypes";
public $dashboardTitle ="Contract Types";
public $breadCrumbTitle ="Contract Types";
public $idField ="ContractTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ContractTypeID"];
public $gridFields = [

"ContractTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContractTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ContractTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContractTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContractTypeID" => "Contract Type ID",
"ContractTypeDescription" => "Contract Type Description"];
}?>
