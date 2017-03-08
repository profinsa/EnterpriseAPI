<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "quotetrackingheader";
protected $gridFields =["OrderNumber","QuoteStatus","QuoteDescription","ExpectedCloseDate","SaleProbability","EnteredBy"];
public $dashboardTitle ="QuoteTrackingHeader";
public $breadCrumbTitle ="QuoteTrackingHeader";
public $idField ="OrderNumber";
public $editCategories = [
"Main" => [

"OrderNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuoteStatus" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuoteDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuoteLongDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpectedCloseDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"SaleProbability" => [
"inputType" => "text",
"defaultValue" => ""
],
"SpecialInstructions" => [
"inputType" => "text",
"defaultValue" => ""
],
"SpecialNeeds" => [
"inputType" => "text",
"defaultValue" => ""
],
"EnteredBy" => [
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
]
]];
public $columnNames = [

"OrderNumber" => "Order Number",
"QuoteStatus" => "Quote Status",
"QuoteDescription" => "Quote Description",
"ExpectedCloseDate" => "Expected Close Date",
"SaleProbability" => "Sale Probability",
"EnteredBy" => "Entered By",
"QuoteLongDescription" => "Quote Long Description",
"SpecialInstructions" => "Special Instructions",
"SpecialNeeds" => "Special Needs",
"ApprovedDate" => "Approved Date",
"CommentNumber" => "Comment Number",
"CommentDate" => "Comment Date",
"Comment" => "Comment",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy"];
}?>
