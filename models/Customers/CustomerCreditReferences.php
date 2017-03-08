<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customercreditreferences";
protected $gridFields =["CustomerID","ReferenceID","ReferenceName","ReferenceDate","ReferenceSoldSince","ReferenceHighCredit"];
public $dashboardTitle ="Customer Credit References";
public $breadCrumbTitle ="Customer Credit References";
public $idField ="CustomerID";
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
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceFactor" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceSoldSince" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceLastSale" => [
"inputType" => "text",
"defaultValue" => ""
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
"inputType" => "text",
"defaultValue" => ""
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
"ReferenceFactor" => "Reference Factor",
"ReferenceLastSale" => "Reference Last Sale",
"ReferenceCurrentBalance" => "Reference Current Balance",
"ReferencePastDue" => "Reference Past Due",
"ReferencePromptPerc" => "Reference Prompt Perc",
"ReferenceLateDays" => "Reference Late Days",
"ReferenceFutures" => "Reference Futures",
"ReferenceComments" => "Reference Comments",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"EnteredBy" => "EnteredBy"];
}?>
