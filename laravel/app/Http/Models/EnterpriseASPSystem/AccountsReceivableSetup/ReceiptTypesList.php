<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "receipttypes";
public $dashboardTitle ="ReceiptTypes";
public $breadCrumbTitle ="ReceiptTypes";
public $idField ="ReceiptTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ReceiptTypeID"];
public $gridFields = [

"ReceiptTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReceiptTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ReceiptTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReceiptTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ReceiptTypeID" => "Receipt Type ID",
"ReceiptTypeDescription" => "Receipt Type Description"];
}?>
