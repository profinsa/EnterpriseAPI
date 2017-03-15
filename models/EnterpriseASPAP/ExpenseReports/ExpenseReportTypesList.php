<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "expensereporttypes";
public $dashboardTitle ="ExpenseReportTypes";
public $breadCrumbTitle ="ExpenseReportTypes";
public $idField ="ExpenseReportType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ExpenseReportType"];
public $gridFields = [

"ExpenseReportType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ExpenseReportTypeDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ExpenseReportType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportTypeDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ExpenseReportType" => "Expense Report Type",
"ExpenseReportTypeDescription" => "Description"];
}?>
