<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customershipforlocations";
protected $gridFields =["CustomerID","ShipToID","ShipForID","ShipForName","ShipForAttention"];
public $dashboardTitle ="Customer Ship For Locations";
public $breadCrumbTitle ="Customer Ship For Locations";
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
"ShipForID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForAddress3" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForState" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForeCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForWebPage" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForAttention" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForNotes" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"ShipToID" => "Ship To ID",
"ShipForID" => "Ship For ID",
"ShipForName" => "Ship For Name",
"ShipForAttention" => "Ship For Attention",
"ShipForAddress1" => "Ship For Address 1",
"ShipForAddress2" => "Ship For Address 2",
"ShipForAddress3" => "Ship For Address 3",
"ShipForCity" => "Ship For City",
"ShipForState" => "Ship For State",
"ShipForZip" => "Ship For Zip",
"ShipForEmail" => "Ship For Email",
"ShipForWebPage" => "Ship For Web Page",
"ShipForNotes" => "Ship For Notes",
"ShipForeCountry" => "Ship For Country"];
}?>
