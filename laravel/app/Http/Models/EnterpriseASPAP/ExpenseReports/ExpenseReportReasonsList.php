<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "expensereportreasons";
public $dashboardTitle ="ExpenseReportReasons";
public $breadCrumbTitle ="ExpenseReportReasons";
public $idField ="ExpenseReportReason";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ExpenseReportReason"];
public $gridFields = [

"ExpenseReportReason" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ExpenseReportReasonDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ExpenseReportReason" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportReasonDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ExpenseReportReason" => "Expense Report Reason",
"ExpenseReportReasonDescription" => "Description"];
}?>
