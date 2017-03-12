<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeeseventtypes";
protected $gridFields =["EventID","EventDescription"];
public $dashboardTitle ="PayrollEmployeesEventTypes";
public $breadCrumbTitle ="PayrollEmployeesEventTypes";
public $idField ="EventID";
public $editCategories = [
"Main" => [

"EventID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EventDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EventID" => "Event ID",
"EventDescription" => "Event Description"];
}?>
