<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contactindustry";
public $dashboardTitle ="Contact Industry";
public $breadCrumbTitle ="Contact Industry";
public $idField ="ContactIndustryID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ContactIndustryID"];
public $gridFields = [

"ContactIndustryID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactIndustryDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ContactIndustryID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactIndustryDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContactIndustryID" => "Contact Industry ID",
"ContactIndustryDescription" => "Contact Industry Description"];
}?>
