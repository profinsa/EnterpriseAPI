<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "artransactiontypes";
public $dashboardTitle ="AR Transaction Types";
public $breadCrumbTitle ="AR Transaction Types";
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
