<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companiesnextnumbers";
protected $gridFields =[];
public $dashboardTitle ="CompaniesNextNumbers";
public $breadCrumbTitle ="CompaniesNextNumbers";
public $idField ="NextNumberName";
public $idFields = ["CompanyID","DivisionID","DepartmentID","NextNumberName"];
public $editCategories = [
"Main" => [

"NextNumberName" => [
"inputType" => "text",
"defaultValue" => ""
],
"NextNumberValue" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"NextNumberName" => "NextNumberName",
"NextNumberValue" => "NextNumberValue"];
}?>
