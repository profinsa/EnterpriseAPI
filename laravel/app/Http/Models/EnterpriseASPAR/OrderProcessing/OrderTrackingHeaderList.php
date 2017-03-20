<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ordertrackingheader";
public $dashboardTitle ="OrderTrackingHeader";
public $breadCrumbTitle ="OrderTrackingHeader";
public $idField ="OrderNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","OrderNumber"];
public $gridFields = [

"OrderNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"OrderDescription" => [
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

"OrderNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"OrderDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"OrderLongDescription" => [
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

"OrderNumber" => "Order Number",
"OrderDescription" => "Order Description",
"SpecialInstructions" => "Special Instructions",
"SpecialNeeds" => "Special Needs",
"EnteredBy" => "Entered By",
"OrderLongDescription" => "OrderLongDescription",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate"];
}?>
