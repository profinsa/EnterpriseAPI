<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customershiptolocations";
protected $gridFields =["CustomerID","ShipToID","ShipToName","ShipToAttention"];
public $dashboardTitle ="Customer Ship To Locations";
public $breadCrumbTitle ="Customer Ship To Locations";
public $idField ="CustomerID";
public $editCategories = [
"Main" => [

"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToAddress3" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToState" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToWebPage" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToAttention" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToNotes" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"ShipToID" => "Ship To ID",
"ShipToName" => "Ship To Name",
"ShipToAttention" => "Ship To Attention",
"ShipToAddress1" => "Ship To Address 1",
"ShipToAddress2" => "Ship To Address 2",
"ShipToAddress3" => "Ship To Address 3",
"ShipToCity" => "Ship To City",
"ShipToState" => "Ship To State",
"ShipToZip" => "Ship To Zip",
"ShipToEmail" => "Ship To Email",
"ShipToWebPage" => "Ship To Web Page",
"ShipToNotes" => "Ship To Notes",
"ShipToCountry" => "Ship To Country"];
}?>
