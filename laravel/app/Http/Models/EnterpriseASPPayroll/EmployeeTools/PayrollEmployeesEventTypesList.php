<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeeseventtypes";
public $dashboardTitle ="PayrollEmployeesEventTypes";
public $breadCrumbTitle ="PayrollEmployeesEventTypes";
public $idField ="EventID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EventID"];
public $gridFields = [

"EventID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EventDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EventID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EventDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EventID" => "Event ID",
"EventDescription" => "Event Description"];
}?>
