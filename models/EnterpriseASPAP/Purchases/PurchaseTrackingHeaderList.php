<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "purchasetrackingheader";
public $dashboardTitle ="PurchaseTrackingHeader";
public $breadCrumbTitle ="PurchaseTrackingHeader";
public $idField ="PurchaseNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PurchaseNumber"];
public $gridFields = [

"PurchaseNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PurchaseDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"SpecialInstructions" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
],
"SpecialNeeds" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
],
"EnteredBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PurchaseNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseLongDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"SpecialInstructions" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"SpecialNeeds" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"EnteredBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"PurchaseNumber" => "Purchase Number",
"PurchaseDescription" => "Purchase Description",
"SpecialInstructions" => "Special Instructions",
"SpecialNeeds" => "Special Needs",
"EnteredBy" => "Entered By",
"PurchaseLongDescription" => "PurchaseLongDescription",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate"];
}?>
