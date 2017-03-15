<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "receipttypes";
protected $gridFields =["ReceiptTypeID","ReceiptTypeDescription"];
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
