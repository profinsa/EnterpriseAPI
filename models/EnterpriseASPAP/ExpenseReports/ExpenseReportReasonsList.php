<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "expensereportreasons";
protected $gridFields =["ExpenseReportReason","ExpenseReportReasonDescription"];
public $dashboardTitle ="ExpenseReportReasons";
public $breadCrumbTitle ="ExpenseReportReasons";
public $idField ="ExpenseReportReason";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ExpenseReportReason"];
public $editCategories = [
"Main" => [

"ExpenseReportReason" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportReasonDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ExpenseReportReason" => "Expense Report Reason",
"ExpenseReportReasonDescription" => "Description"];
}?>
