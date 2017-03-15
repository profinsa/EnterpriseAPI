<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgertransactiontypes";
protected $gridFields =["TransactionTypeID","TransactionTypeDescription"];
public $dashboardTitle ="Ledger Transaction Types";
public $breadCrumbTitle ="Ledger Transaction Types";
public $idField ="TransactionTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TransactionTypeID"];
public $editCategories = [
"Main" => [

"TransactionTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"TransactionTypeID" => "Transaction Type ID",
"TransactionTypeDescription" => "Transaction Type Description"];
}?>
