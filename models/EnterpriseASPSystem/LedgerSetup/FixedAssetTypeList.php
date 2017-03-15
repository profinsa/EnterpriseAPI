<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "fixedassettype";
protected $gridFields =["AssetTypeID","AssetTypeDescription"];
public $dashboardTitle ="Fixed Asset Type";
public $breadCrumbTitle ="Fixed Asset Type";
public $idField ="AssetTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AssetTypeID"];
public $editCategories = [
"Main" => [

"AssetTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AssetTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AssetTypeID" => "Asset Type ID",
"AssetTypeDescription" => "Asset Type Description"];
}?>
