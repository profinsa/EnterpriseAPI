<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeepaytype";
protected $gridFields =["EmployeePayTypeID","EmployeePayTypeDescription"];
public $dashboardTitle ="PayrollEmployeePayType";
public $breadCrumbTitle ="PayrollEmployeePayType";
public $idField ="EmployeePayTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeePayTypeID"];
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
