<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "quotetrackingheader";
public $dashboardTitle ="QuoteTrackingHeader";
public $breadCrumbTitle ="QuoteTrackingHeader";
public $idField ="OrderNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","OrderNumber"];
public $gridFields = [

"OrderNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"QuoteStatus" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"QuoteDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"ExpectedCloseDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"SaleProbability" => [
    "dbType" => "int(11)",
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
"QuoteStatus" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"QuoteDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"QuoteLongDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpectedCloseDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"SaleProbability" => [
"dbType" => "int(11)",
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
"inputType" => "text",
"defaultValue" => ""
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
"QuoteStatus" => "Quote Status",
"QuoteDescription" => "Quote Description",
"ExpectedCloseDate" => "Expected Close Date",
"SaleProbability" => "Sale Probability",
"EnteredBy" => "Entered By",
"QuoteLongDescription" => "QuoteLongDescription",
"SpecialInstructions" => "SpecialInstructions",
"SpecialNeeds" => "SpecialNeeds",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate"];
}?>
