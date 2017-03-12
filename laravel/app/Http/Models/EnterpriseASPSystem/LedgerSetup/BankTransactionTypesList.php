<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "banktransactiontypes";
protected $gridFields =["BankTransactionTypeID","BankTransactionTypeDesc"];
public $dashboardTitle ="Bank Transaction Types";
public $breadCrumbTitle ="Bank Transaction Types";
public $idField ="BankTransactionTypeID";
public $editCategories = [
"Main" => [

"BankTransactionTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankTransactionTypeDesc" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"BankTransactionTypeID" => "Bank Transaction Type ID",
"BankTransactionTypeDesc" => "Bank Transaction Type Description"];
}?>
