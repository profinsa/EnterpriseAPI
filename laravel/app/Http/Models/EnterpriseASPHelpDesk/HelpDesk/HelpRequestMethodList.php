<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helprequestmethod";
protected $gridFields =["RequestMethod","RequestMethodDescription"];
public $dashboardTitle ="Help Request Methods";
public $breadCrumbTitle ="Help Request Methods";
public $idField ="RequestMethod";
public $editCategories = [
"Main" => [

"RequestMethod" => [
"inputType" => "text",
"defaultValue" => ""
],
"RequestMethodDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"RequestMethod" => "Request Method",
"RequestMethodDescription" => "Request Method Description"];
}?>
