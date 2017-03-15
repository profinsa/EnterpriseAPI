<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "projects";
public $dashboardTitle ="Projects";
public $breadCrumbTitle ="Projects";
public $idField ="ProjectID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ProjectID"];
public $gridFields = [

"ProjectID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ProjectName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ProjectTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CustomerID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ProjectStartDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"ProjectOpen" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ProjectID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CustomerID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectStartDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ProjectCompleteDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CurrencyID" => [
"dbType" => "varchar(3)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectEstRevenue" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectActualRevenue" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectEstCost" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectActualCost" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectNotes" => [
"dbType" => "varchar(250)",
"inputType" => "text",
"defaultValue" => ""
],
"GLSalesAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectOpen" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Memorize" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ProjectID" => "Project ID",
"ProjectName" => "Project Name",
"ProjectTypeID" => "Project Type",
"CustomerID" => "Customer ID",
"EmployeeID" => "Employee ID",
"ProjectStartDate" => "Start Date",
"ProjectOpen" => "Open",
"ProjectDescription" => "ProjectDescription",
"ProjectCompleteDate" => "ProjectCompleteDate",
"CurrencyID" => "CurrencyID",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"ProjectEstRevenue" => "ProjectEstRevenue",
"ProjectActualRevenue" => "ProjectActualRevenue",
"ProjectEstCost" => "ProjectEstCost",
"ProjectActualCost" => "ProjectActualCost",
"ProjectNotes" => "ProjectNotes",
"GLSalesAccount" => "GLSalesAccount",
"Memorize" => "Memorize"];
}?>
