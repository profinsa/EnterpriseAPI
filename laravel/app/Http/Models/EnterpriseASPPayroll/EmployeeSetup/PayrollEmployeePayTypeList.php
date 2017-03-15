<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeepaytype";
public $dashboardTitle ="PayrollEmployeePayType";
public $breadCrumbTitle ="PayrollEmployeePayType";
public $idField ="EmployeePayTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeePayTypeID"];
public $gridFields = [

"EmployeePayTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeePayTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeePayTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePayTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeePayTypeID" => "Employee Pay Type ID",
"EmployeePayTypeDescription" => "Employee Pay Type Description"];
}?>
