<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customershipforlocations";
protected $gridFields =["CustomerID","ShipToID","ShipForID","ShipForName","ShipForAttention"];
public $dashboardTitle ="Customer Ship For Locations";
public $breadCrumbTitle ="Customer Ship For Locations";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ShipToID","ShipForID"];
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
"ShipForAddress1" => "ShipForAddress1",
"ShipForAddress2" => "ShipForAddress2",
"ShipForAddress3" => "ShipForAddress3",
"ShipForCity" => "ShipForCity",
"ShipForState" => "ShipForState",
"ShipForZip" => "ShipForZip",
"ShipForeCountry" => "ShipForeCountry",
"ShipForEmail" => "ShipForEmail",
"ShipForWebPage" => "ShipForWebPage",
"ShipForNotes" => "ShipForNotes"];
}?>
