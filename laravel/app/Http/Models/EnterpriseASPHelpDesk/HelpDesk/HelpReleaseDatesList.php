<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpreleasedates";
public $gridFields =["ProductName","CurrentVersion","NextVersion","ReleaseDate","Notes"];
public $dashboardTitle ="Help Release Dates";
public $breadCrumbTitle ="Help Release Dates";
public $idField ="ProductName";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ProductName","CurrentVersion"];
public $editCategories = [
"Main" => [

"ProductName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrentVersion" => [
"inputType" => "text",
"defaultValue" => ""
],
"NextVersion" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReleaseDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Notes" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ProductName" => "Product Name",
"CurrentVersion" => "Current Version",
"NextVersion" => "Next Version",
"ReleaseDate" => "Release Date",
"Notes" => "Notes"];
}?>
