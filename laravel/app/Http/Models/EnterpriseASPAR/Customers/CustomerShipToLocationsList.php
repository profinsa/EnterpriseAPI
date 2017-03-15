<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customershiptolocations";
public $gridFields =["CustomerID","ShipToID","ShipToName","ShipToAttention"];
public $dashboardTitle ="Customer Ship To Locations";
public $breadCrumbTitle ="Customer Ship To Locations";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ShipToID"];
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
"ShipToAddress1" => "ShipToAddress1",
"ShipToAddress2" => "ShipToAddress2",
"ShipToAddress3" => "ShipToAddress3",
"ShipToCity" => "ShipToCity",
"ShipToState" => "ShipToState",
"ShipToZip" => "ShipToZip",
"ShipToCountry" => "ShipToCountry",
"ShipToEmail" => "ShipToEmail",
"ShipToWebPage" => "ShipToWebPage",
"ShipToNotes" => "ShipToNotes"];
}?>
