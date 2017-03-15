<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "expensereportitems";
protected $gridFields =["ExpenseReportItemID","ExpenseReportItemDescription","ExpsneseReportGLAccount","ExpenseReportMilageRate"];
public $dashboardTitle ="ExpenseReportItems";
public $breadCrumbTitle ="ExpenseReportItems";
public $idField ="ExpenseReportItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ExpenseReportItemID"];
public $editCategories = [
"Main" => [

"ExpenseReportItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportItemDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpsneseReportGLAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMilageRate" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ExpenseReportItemID" => "Expense Report Item ID",
"ExpenseReportItemDescription" => "Description",
"ExpsneseReportGLAccount" => "GL Account",
"ExpenseReportMilageRate" => "Milage Rate"];
}?>
