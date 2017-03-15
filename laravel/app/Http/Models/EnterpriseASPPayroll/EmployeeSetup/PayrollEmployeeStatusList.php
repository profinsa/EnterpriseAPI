<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestatus";
public $dashboardTitle ="PayrollEmployeeStatus";
public $breadCrumbTitle ="PayrollEmployeeStatus";
public $idField ="EmployeeStatusID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeStatusID"];
public $gridFields = [

"EmployeeStatusID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeStatusDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeStatusID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeStatusDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeStatusID" => "Employee Status ID",
"EmployeeStatusDescription" => "Employee Status Description"];
}?>
