<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeesaccrualfrequency";
protected $gridFields =["AccrualFrequency","AccruslFrequencyDescription","AccrualFrequencyRate","AccrualFrequencyUnit"];
public $dashboardTitle ="PayrollEmployeesAccrualFrequency";
public $breadCrumbTitle ="PayrollEmployeesAccrualFrequency";
public $idField ="AccrualFrequency";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AccrualFrequency"];
public $editCategories = [
"Main" => [

"AccrualFrequency" => [
"inputType" => "text",
"defaultValue" => ""
],
"AccruslFrequencyDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"AccrualFrequencyRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"AccrualFrequencyUnit" => [
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
