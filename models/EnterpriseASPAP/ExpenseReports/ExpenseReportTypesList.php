<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "expensereporttypes";
protected $gridFields =["ExpenseReportType","ExpenseReportTypeDescription"];
public $dashboardTitle ="ExpenseReportTypes";
public $breadCrumbTitle ="ExpenseReportTypes";
public $idField ="ExpenseReportType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ExpenseReportType"];
public $editCategories = [
"Main" => [

"ExpenseReportType" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ExpenseReportType" => "Expense Report Type",
"ExpenseReportTypeDescription" => "Description"];
}?>
