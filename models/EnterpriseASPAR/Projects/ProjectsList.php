<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "projects";
protected $gridFields =["ProjectID","ProjectName","ProjectTypeID","CustomerID","EmployeeID","ProjectStartDate","ProjectOpen"];
public $dashboardTitle ="Projects";
public $breadCrumbTitle ="Projects";
public $idField ="ProjectID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ProjectID"];
public $editCategories = [
"Main" => [

"ProjectID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectStartDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"ProjectCompleteDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectEstRevenue" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectActualRevenue" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectEstCost" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectActualCost" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLSalesAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectOpen" => [
"inputType" => "text",
"defaultValue" => ""
],
"Memorize" => [
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
