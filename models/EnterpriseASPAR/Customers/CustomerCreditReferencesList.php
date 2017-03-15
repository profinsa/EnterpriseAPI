<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customercreditreferences";
protected $gridFields =["CustomerID","ReferenceID","ReferenceName","ReferenceDate","ReferenceSoldSince","ReferenceHighCredit"];
public $dashboardTitle ="Customer Credit References";
public $breadCrumbTitle ="Customer Credit References";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ReferenceID"];
public $editCategories = [
"Main" => [

"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ReferenceFactor" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceSoldSince" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ReferenceLastSale" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ReferenceHighCredit" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceCurrentBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferencePastDue" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferencePromptPerc" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceLateDays" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceFutures" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceComments" => [
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"ReferenceID" => "Reference ID",
"ReferenceName" => "Reference Name",
"ReferenceDate" => "Reference Date",
"ReferenceSoldSince" => "Reference Sold Since",
"ReferenceHighCredit" => "Reference High Credit",
"ReferenceFactor" => "ReferenceFactor",
"ReferenceLastSale" => "ReferenceLastSale",
"ReferenceCurrentBalance" => "ReferenceCurrentBalance",
"ReferencePastDue" => "ReferencePastDue",
"ReferencePromptPerc" => "ReferencePromptPerc",
"ReferenceLateDays" => "ReferenceLateDays",
"ReferenceFutures" => "ReferenceFutures",
"ReferenceComments" => "ReferenceComments",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"EnteredBy" => "EnteredBy"];
}?>
