<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "receiptmethods";
public $dashboardTitle ="ReceiptMethods";
public $breadCrumbTitle ="ReceiptMethods";
public $idField ="ReceiptMethodID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ReceiptMethodID"];
public $gridFields = [

"ReceiptMethodID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReceiptMethodDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ReceiptMethodID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReceiptMethodDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ReceiptMethodID" => "Receipt Method ID",
"ReceiptMethodDescription" => "Receipt Method Description"];
}?>
