<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "receipttypes";
public $gridFields =["ReceiptTypeID","ReceiptTypeDescription"];
public $dashboardTitle ="ReceiptTypes";
public $breadCrumbTitle ="ReceiptTypes";
public $idField ="ReceiptTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ReceiptTypeID"];
public $editCategories = [
"Main" => [

"ReceiptTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReceiptTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ReceiptTypeID" => "Receipt Type ID",
"ReceiptTypeDescription" => "Receipt Type Description"];
}?>
