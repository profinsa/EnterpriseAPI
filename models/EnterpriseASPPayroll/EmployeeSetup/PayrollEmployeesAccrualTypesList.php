<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeesaccrualtypes";
public $gridFields =["AccrualID","AccrualDescription","AccrualFrequency","AccrualGlAccount"];
public $dashboardTitle ="PayrollEmployeesAccrualTypes";
public $breadCrumbTitle ="PayrollEmployeesAccrualTypes";
public $idField ="AccrualID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AccrualID"];
public $editCategories = [
"Main" => [

"AccrualID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AccrualDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"AccrualFrequency" => [
"inputType" => "text",
"defaultValue" => ""
],
"AccrualGlAccount" => [
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
