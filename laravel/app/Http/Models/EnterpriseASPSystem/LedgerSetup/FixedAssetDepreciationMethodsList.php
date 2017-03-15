<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "fixedassetdepreciationmethods";
public $dashboardTitle ="Fixed Asset Depreciation Methods";
public $breadCrumbTitle ="Fixed Asset Depreciation Methods";
public $idField ="AssetDepreciationMethodID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AssetDepreciationMethodID"];
public $gridFields = [

"AssetDepreciationMethodID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"DepreciationMethodDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"DepreciationFormula" => [
    "dbType" => "varchar(250)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"AssetDepreciationMethodID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"DepreciationMethodDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepreciationFormula" => [
"dbType" => "varchar(250)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AssetDepreciationMethodID" => "Asset Depreciation Method ID",
"DepreciationMethodDescription" => "Depreciation Method Description",
"DepreciationFormula" => "Depreciation Formula"];
}?>
