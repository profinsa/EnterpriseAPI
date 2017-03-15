<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeesaccrualtypes";
public $dashboardTitle ="PayrollEmployeesAccrualTypes";
public $breadCrumbTitle ="PayrollEmployeesAccrualTypes";
public $idField ="AccrualID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AccrualID"];
public $gridFields = [

"AccrualID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AccrualDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
],
"AccrualFrequency" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AccrualGlAccount" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"AccrualID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AccrualDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"AccrualFrequency" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AccrualGlAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AccrualID" => "Accrual ID",
"AccrualDescription" => "Accrual Description",
"AccrualFrequency" => "Accrual Frequency",
"AccrualGlAccount" => "Accrual Gl Account"];
}?>
