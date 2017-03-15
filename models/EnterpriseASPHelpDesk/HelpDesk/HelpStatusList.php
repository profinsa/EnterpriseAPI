<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpstatus";
protected $gridFields =["StatusId","StatusDescription"];
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
