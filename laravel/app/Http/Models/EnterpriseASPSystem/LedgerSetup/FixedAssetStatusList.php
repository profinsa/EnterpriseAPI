<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "fixedassetstatus";
protected $gridFields =["AssetStatusID","AssetStatusDescription"];
public $dashboardTitle ="Fixed Asset Status";
public $breadCrumbTitle ="Fixed Asset Status";
public $idField ="AssetStatusID";
public $editCategories = [
"Main" => [

"AssetStatusID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AssetStatusDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AssetStatusID" => "Asset Status ID",
"AssetStatusDescription" => "Asset Status Description"];
}?>