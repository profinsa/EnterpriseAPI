<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeepayfrequency";
protected $gridFields =["EmployeePayFrequencyID","EmployeePayFrequencyDescription"];
public $dashboardTitle ="PayrollEmployeePayFrequency";
public $breadCrumbTitle ="PayrollEmployeePayFrequency";
public $idField ="EmployeePayFrequencyID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeePayFrequencyID"];
public $editCategories = [
"Main" => [

"EmployeePayFrequencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePayFrequencyDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeePayFrequencyID" => "Employee Pay Frequency ID",
"EmployeePayFrequencyDescription" => "Employee Pay Frequency Description"];
}?>
