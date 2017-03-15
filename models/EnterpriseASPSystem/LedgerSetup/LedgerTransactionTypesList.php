<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgertransactiontypes";
public $dashboardTitle ="Ledger Transaction Types";
public $breadCrumbTitle ="Ledger Transaction Types";
public $idField ="TransactionTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TransactionTypeID"];
public $gridFields = [

"TransactionTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TransactionTypeDescription" => [
    "dbType" => "varchar(80)",
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
"TransactionTypeDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"TransactionTypeID" => "Transaction Type ID",
"TransactionTypeDescription" => "Transaction Type Description"];
}?>
