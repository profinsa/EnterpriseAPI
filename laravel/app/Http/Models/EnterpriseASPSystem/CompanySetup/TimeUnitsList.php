<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "timeunits";
public $gridFields =["TimeUnitID","TimeUnitDescription"];
public $dashboardTitle ="TimeUnits";
public $breadCrumbTitle ="TimeUnits";
public $idField ="TimeUnitID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TimeUnitID"];
public $editCategories = [
"Main" => [

"TimeUnitID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TimeUnitDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"TimeUnitID" => "Time Unit ID",
"TimeUnitDescription" => "Time Unit Description"];
}?>
