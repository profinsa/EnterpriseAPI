<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestatustype";
public $dashboardTitle ="Payroll Employee Status Types";
public $breadCrumbTitle ="Payroll Employee Status Types";
public $idField ="EmployeeStatusTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeStatusTypeID"];
public $gridFields = [

"EmployeeStatusTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeStatusTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeStatusTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeStatusTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeStatusTypeID" => "Employee Status Type ID",
"EmployeeStatusTypeDescription" => "Employee Status Type Description"];
}?>
