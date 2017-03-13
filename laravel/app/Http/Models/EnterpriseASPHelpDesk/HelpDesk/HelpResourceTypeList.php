<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpresourcetype";
protected $gridFields =["ResourceType","ResourceTypeDescription"];
public $dashboardTitle ="Help Resource Types";
public $breadCrumbTitle ="Help Resource Types";
public $idField ="ResourceType";
public $editCategories = [
"Main" => [

"ResourceType" => [
"inputType" => "text",
"defaultValue" => ""
],
"ResourceTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ResourceType" => "Resource Type",
"ResourceTypeDescription" => "Resource Type Description"];
}?>