<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "artransactiontypes";
protected $gridFields =["TransactionTypeID","TransactionDescription"];
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
