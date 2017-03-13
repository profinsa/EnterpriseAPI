<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "aptransactiontypes";
protected $gridFields =["TransactionTypeID","TransactionDescription"];
public $dashboardTitle ="AP Transaction Types";
public $breadCrumbTitle ="AP Transaction Types";
public $idField ="TransactionTypeID";
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