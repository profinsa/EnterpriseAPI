<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contactindustry";
public $gridFields =["ContactIndustryID","ContactIndustryDescription"];
public $dashboardTitle ="Contact Industry";
public $breadCrumbTitle ="Contact Industry";
public $idField ="ContactIndustryID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ContactIndustryID"];
public $editCategories = [
"Main" => [

"ContactIndustryID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactIndustryDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContactIndustryID" => "Contact Industry ID",
"ContactIndustryDescription" => "Contact Industry Description"];
}?>
