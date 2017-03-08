<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customercontactlog";
protected $gridFields =["CustomerID","ContactID","ContactLogID","ContactDate","ContactDesctiption"];
public $dashboardTitle ="Customer Contact Log";
public $breadCrumbTitle ="Customer Contact Log";
public $idField ="CustomerID";
public $editCategories = [
"Main" => [

"ContactLogID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactCallStartTime" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactCallEndTime" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactDesctiption" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"ContactID" => "Contact ID",
"ContactLogID" => "Contact Log ID",
"ContactDate" => "Contact Date",
"ContactDesctiption" => "Descrtiption",
"ContactCallStartTime" => "Call Start Time",
"ContactCallEndTime" => "Call End Time"];
}?>
