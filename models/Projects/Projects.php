<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "projects"
;protected $gridFields =["ProjectID","ProjectName","ProjectTypeID","CustomerID","EmployeeID","ProjectStartDate","ProjectOpen"];
public $dashboardTitle ="Projects";
public $breadCrumbTitle ="Projects";
public $idField ="ProjectID";
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
"ProjectStartDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectCompleteDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectEstRevenue" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectEstCost" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectActualRevenue" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectActualCost" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionType" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerID" => [
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
"ProjectStartDate" => "Project Start Date",
"ProjectOpen" => "Open",
"ProjectDescription" => "Project Description",
"ProjectCompleteDate" => "Project Complete Date",
"ProjectEstRevenue" => "Project Est Revenue",
"ProjectEstCost" => "Project Est Cost",
"ProjectActualRevenue" => "Project Actual Revenue",
"ProjectActualCost" => "Project Actual Cost",
"ProjectNotes" => "Project Notes",
"TransactionType" => "Transaction Type",
"TransactionNumber" => "Transaction Number",
"TransactionDate" => "Transaction Date",
"TransactionAmount" => "Transaction Amount",
"CurrencyID" => "Currency ID"];
}?>
