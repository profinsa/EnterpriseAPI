<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "banktransactiontypes";
public $dashboardTitle ="Bank Transaction Types";
public $breadCrumbTitle ="Bank Transaction Types";
public $idField ="BankTransactionTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","BankTransactionTypeID"];
public $gridFields = [

"BankTransactionTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"BankTransactionTypeDesc" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"BankTransactionTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"BankTransactionTypeDesc" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"BankTransactionTypeID" => "Bank Transaction Type ID",
"BankTransactionTypeDesc" => "Bank Transaction Type Description"];
}?>
