<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "expensereporttypes";
protected $gridFields =["ExpenseReportType","ExpenseReportTypeDescription"];
public $dashboardTitle ="ExpenseReportTypes";
public $breadCrumbTitle ="ExpenseReportTypes";
public $idField ="ExpenseReportType";
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
