<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeedepartment";
public $dashboardTitle ="PayrollEmployeeDepartment";
public $breadCrumbTitle ="PayrollEmployeeDepartment";
public $idField ="EmployeeDepartmentID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeDepartmentID"];
public $gridFields = [

"EmployeeDepartmentID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeDepartmentDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeDepartmentID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeDepartmentDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeDepartmentID" => "Employee Department ID",
"EmployeeDepartmentDescription" => "Employee Department Description"];
}?>
