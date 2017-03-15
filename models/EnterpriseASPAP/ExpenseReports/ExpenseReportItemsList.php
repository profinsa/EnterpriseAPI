<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "expensereportitems";
public $dashboardTitle ="ExpenseReportItems";
public $breadCrumbTitle ="ExpenseReportItems";
public $idField ="ExpenseReportItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ExpenseReportItemID"];
public $gridFields = [

"ExpenseReportItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ExpenseReportItemDescription" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ExpsneseReportGLAccount" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ExpenseReportMilageRate" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ExpenseReportItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportItemDescription" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpsneseReportGLAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMilageRate" => [
"dbType" => "decimal(19,4)",
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
