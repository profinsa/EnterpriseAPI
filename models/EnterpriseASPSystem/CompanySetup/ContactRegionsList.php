<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contactregions";
public $gridFields =["ContactRegionID","ContactRegionDescription"];
public $dashboardTitle ="Contact Regions";
public $breadCrumbTitle ="Contact Regions";
public $idField ="ContactRegionID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ContactRegionID"];
public $editCategories = [
"Main" => [

"ContactRegionID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactRegionDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContactRegionID" => "Contact Region ID",
"ContactRegionDescription" => "Contact Region Description"];
}?>
