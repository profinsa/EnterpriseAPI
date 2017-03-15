<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contactregions";
public $dashboardTitle ="Contact Regions";
public $breadCrumbTitle ="Contact Regions";
public $idField ="ContactRegionID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ContactRegionID"];
public $gridFields = [

"ContactRegionID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactRegionDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ContactRegionID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactRegionDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContactRegionID" => "Contact Region ID",
"ContactRegionDescription" => "Contact Region Description"];
}?>
