<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "receiptclass";
public $dashboardTitle ="Receipt Class";
public $breadCrumbTitle ="Receipt Class";
public $idField ="ReceiptClassID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ReceiptClassID"];
public $gridFields = [

"ReceiptClassID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReceiptClassDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ReceiptClassID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReceiptClassDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ReceiptClassID" => "Receipt Class ID",
"ReceiptClassDescription" => "Receipt Class Description"];
}?>
