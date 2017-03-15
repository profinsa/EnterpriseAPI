<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "salesgroup";
protected $gridFields =["SalesGroupID","EmployeeID","SalesGroupSupervisor","ComissionPerc","ComissionType"];
public $dashboardTitle ="SalesGroup";
public $breadCrumbTitle ="SalesGroup";
public $idField ="SalesGroupID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","SalesGroupID","EmployeeID"];
public $editCategories = [
"Main" => [

"SalesGroupID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"SalesGroupDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"SalesGroupSupervisor" => [
"inputType" => "text",
"defaultValue" => ""
],
"SplitCommission" => [
"inputType" => "text",
"defaultValue" => ""
],
"ComissionPerc" => [
"inputType" => "text",
"defaultValue" => ""
],
"ComissionType" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"SalesGroupID" => "Sales Group ID",
"EmployeeID" => "Employee ID",
"SalesGroupSupervisor" => "Sales Group Supervisor",
"ComissionPerc" => "Comission Perc",
"ComissionType" => "Comission Type",
"SalesGroupDescription" => "SalesGroupDescription",
"SplitCommission" => "SplitCommission"];
}?>
