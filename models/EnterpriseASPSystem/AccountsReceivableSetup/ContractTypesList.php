<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contracttypes";
public $gridFields =["ContractTypeID","ContractTypeDescription"];
public $dashboardTitle ="Contract Types";
public $breadCrumbTitle ="Contract Types";
public $idField ="ContractTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ContractTypeID"];
public $editCategories = [
"Main" => [

"ContractTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContractTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContractTypeID" => "Contract Type ID",
"ContractTypeDescription" => "Contract Type Description"];
}?>
