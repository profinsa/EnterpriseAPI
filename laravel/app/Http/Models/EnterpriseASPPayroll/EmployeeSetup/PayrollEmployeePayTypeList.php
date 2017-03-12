<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeepaytype";
protected $gridFields =["EmployeePayTypeID","EmployeePayTypeDescription"];
public $dashboardTitle ="PayrollEmployeePayType";
public $breadCrumbTitle ="PayrollEmployeePayType";
public $idField ="EmployeePayTypeID";
public $editCategories = [
"Main" => [

"EmployeePayTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePayTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeePayTypeID" => "Employee Pay Type ID",
"EmployeePayTypeDescription" => "Employee Pay Type Description"];
}?>
