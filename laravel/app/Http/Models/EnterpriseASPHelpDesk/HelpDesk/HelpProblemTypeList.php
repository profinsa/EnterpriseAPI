<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpproblemtype";
protected $gridFields =["ProblemType","ProblemTypeDescription"];
public $dashboardTitle ="Help Problem Types";
public $breadCrumbTitle ="Help Problem Types";
public $idField ="ProblemType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ProblemType"];
public $editCategories = [
"Main" => [

"ProblemType" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProblemTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ProblemType" => "Problem Type",
"ProblemTypeDescription" => "Problem Type Description"];
}?>
