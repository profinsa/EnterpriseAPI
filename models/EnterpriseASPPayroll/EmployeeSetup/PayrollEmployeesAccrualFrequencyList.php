<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeesaccrualfrequency";
public $dashboardTitle ="PayrollEmployeesAccrualFrequency";
public $breadCrumbTitle ="PayrollEmployeesAccrualFrequency";
public $idField ="AccrualFrequency";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AccrualFrequency"];
public $gridFields = [

"AccrualFrequency" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AccruslFrequencyDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"AccrualFrequencyRate" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"AccrualFrequencyUnit" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"AccrualFrequency" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AccruslFrequencyDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"AccrualFrequencyRate" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"AccrualFrequencyUnit" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AccrualFrequency" => "Accrual Frequency",
"AccruslFrequencyDescription" => "Accrusl Frequency Description",
"AccrualFrequencyRate" => "Accrual Frequency Rate",
"AccrualFrequencyUnit" => "Accrual Frequency Unit"];
}?>
