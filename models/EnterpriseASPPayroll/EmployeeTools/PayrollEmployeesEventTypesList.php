<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeeseventtypes";
public $gridFields =["EventID","EventDescription"];
public $dashboardTitle ="PayrollEmployeesEventTypes";
public $breadCrumbTitle ="PayrollEmployeesEventTypes";
public $idField ="EventID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EventID"];
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
