<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "aptransactiontypes";
public $dashboardTitle ="AP Transaction Types";
public $breadCrumbTitle ="AP Transaction Types";
public $idField ="TransactionTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TransactionTypeID"];
public $gridFields = [

"TransactionTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TransactionDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TransactionTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TransactionDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"TransactionTypeID" => "Transaction Type ID",
"TransactionDescription" => "Transaction Description"];
}?>
