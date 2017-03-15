<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customershipforlocations";
public $dashboardTitle ="Customer Ship For Locations";
public $breadCrumbTitle ="Customer Ship For Locations";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ShipToID","ShipForID"];
public $gridFields = [

"CustomerID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ShipToID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ShipForID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ShipForName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ShipForAttention" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"CustomerID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipForID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipForName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipForAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipForAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipForAddress3" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipForCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipForState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipForZip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipForeCountry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipForEmail" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipForWebPage" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipForAttention" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipForNotes" => [
"dbType" => "varchar(255)",
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
