<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeestatustype";
protected $gridFields =["EmployeeStatusTypeID","EmployeeStatusTypeDescription"];
public $dashboardTitle ="Payroll Employee Status Types";
public $breadCrumbTitle ="Payroll Employee Status Types";
public $idField ="EmployeeStatusTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeStatusTypeID"];
public $editCategories = [
"Main" => [

"EmployeeStatusTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeStatusTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeStatusTypeID" => "Employee Status Type ID",
"EmployeeStatusTypeDescription" => "Employee Status Type Description"];
}?>
