<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helppriority";
public $gridFields =["Priority","PriorityDescription"];
public $dashboardTitle ="Help Priorities";
public $breadCrumbTitle ="Help Priorities";
public $idField ="Priority";
public $idFields = ["CompanyID","DivisionID","DepartmentID","Priority"];
public $editCategories = [
"Main" => [

"Priority" => [
"inputType" => "text",
"defaultValue" => ""
],
"PriorityDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"Priority" => "Priority",
"PriorityDescription" => "Priority Description"];
}?>
