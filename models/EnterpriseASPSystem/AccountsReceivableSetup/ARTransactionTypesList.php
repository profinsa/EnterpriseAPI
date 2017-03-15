<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "artransactiontypes";
public $gridFields =["TransactionTypeID","TransactionDescription"];
public $dashboardTitle ="AR Transaction Types";
public $breadCrumbTitle ="AR Transaction Types";
public $idField ="TransactionTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TransactionTypeID"];
public $editCategories = [
"Main" => [

"TransactionTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"TransactionTypeID" => "Transaction Type ID",
"TransactionDescription" => "Transaction Description"];
}?>
