<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customeritemcrossreference";
protected $gridFields =["CustomerID","CustomerItemID","CustomerItemDescription","ItemID","ItemDescription"];
public $dashboardTitle ="Customer Item Cross Reference";
public $breadCrumbTitle ="Customer Item Cross Reference";
public $idField ="CustomerID";
public $editCategories = [
"Main" => [

"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerItemDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"CustomerItemID" => "Customer Item ID",
"CustomerItemDescription" => "Customer Item Description",
"ItemID" => "Item ID",
"ItemDescription" => "Item Description"];
}?>
