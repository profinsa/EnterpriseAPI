<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpstatus";
public $gridFields =["StatusId","StatusDescription"];
public $dashboardTitle ="Help Statuses";
public $breadCrumbTitle ="Help Statuses";
public $idField ="StatusId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","StatusId"];
public $editCategories = [
"Main" => [

"StatusId" => [
"inputType" => "text",
"defaultValue" => ""
],
"StatusDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"StatusId" => "Status Id",
"StatusDescription" => "Status Description"];
}?>
