<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestaskpriority";
protected $gridFields =["PriorityID","PriorityDescription"];
public $dashboardTitle ="PayrollEmployeesTaskPriority";
public $breadCrumbTitle ="PayrollEmployeesTaskPriority";
public $idField ="PriorityID";
public $editCategories = [
"Main" => [

"PriorityID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PriorityDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PriorityID" => "Priority ID",
"PriorityDescription" => "Priority Description"];
}?>
