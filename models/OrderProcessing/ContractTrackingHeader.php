<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contracttrackingheader"
;protected $gridFields =["OrderNumber","ContractDescription","SpecialNeeds","EnteredBy"];
public $dashboardTitle ="ContractTrackingHeader";
public $breadCrumbTitle ="ContractTrackingHeader";
public $idField ="OrderNumber";
public $editCategories = [
"Main" => [

"OrderNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContractDescription" => [
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
"ApprovedDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContractNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommentNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommentDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"Comment" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"OrderNumber" => "Contract Number",
"ContractDescription" => "Contract Description",
"SpecialNeeds" => "Special Needs",
"EnteredBy" => "Entered By",
"SpecialInstructions" => "Special Instructions",
"ApprovedDate" => "Approved Date",
"ContractNumber" => "Contract Number",
"CommentNumber" => "Comment Number",
"CommentDate" => "Comment Date",
"Comment" => "Comment"];
}?>
