<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "fixedassetdepreciationmethods";
protected $gridFields =["AssetDepreciationMethodID","DepreciationMethodDescription","DepreciationFormula"];
public $dashboardTitle ="Fixed Asset Depreciation Methods";
public $breadCrumbTitle ="Fixed Asset Depreciation Methods";
public $idField ="AssetDepreciationMethodID";
public $editCategories = [
"Main" => [

"AssetDepreciationMethodID" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepreciationMethodDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepreciationFormula" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AssetDepreciationMethodID" => "Asset Depreciation Method ID",
"DepreciationMethodDescription" => "Depreciation Method Description",
"DepreciationFormula" => "Depreciation Formula"];
}?>
