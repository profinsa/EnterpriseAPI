<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contactregions";
protected $gridFields =["ContactRegionID","ContactRegionDescription"];
public $dashboardTitle ="Contact Regions";
public $breadCrumbTitle ="Contact Regions";
public $idField ="ContactRegionID";
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