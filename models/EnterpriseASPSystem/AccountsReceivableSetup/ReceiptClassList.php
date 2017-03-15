<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "receiptclass";
public $gridFields =["ReceiptClassID","ReceiptClassDescription"];
public $dashboardTitle ="Receipt Class";
public $breadCrumbTitle ="Receipt Class";
public $idField ="ReceiptClassID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ReceiptClassID"];
public $editCategories = [
"Main" => [

"ReceiptClassID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReceiptClassDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ReceiptClassID" => "Receipt Class ID",
"ReceiptClassDescription" => "Receipt Class Description"];
}?>
