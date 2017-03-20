<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "salesgroup";
public $dashboardTitle ="SalesGroup";
public $breadCrumbTitle ="SalesGroup";
public $idField ="SalesGroupID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","SalesGroupID","EmployeeID"];
public $gridFields = [

"SalesGroupID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"SalesGroupSupervisor" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ComissionPerc" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"ComissionType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"SalesGroupID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SalesGroupDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"SalesGroupSupervisor" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SplitCommission" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ComissionPerc" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"ComissionType" => [
"dbType" => "varchar(36)",
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
