<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "aptransactiontypes";
public $gridFields =["TransactionTypeID","TransactionDescription"];
public $dashboardTitle ="AP Transaction Types";
public $breadCrumbTitle ="AP Transaction Types";
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
