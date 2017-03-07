<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ordertrackingheader"
;protected $gridFields =["OrderNumber","OrderDescription","SpecialInstructions","SpecialNeeds","EnteredBy"];
public $dashboardTitle ="OrderTrackingHeader";
public $breadCrumbTitle ="OrderTrackingHeader";
public $idField ="OrderNumber";
public $editCategories = [
"Main" => [

"OrderNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"OrderDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"OrderLongDescription" => [
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

"OrderNumber" => "Order Number",
"OrderDescription" => "Order Description",
"SpecialInstructions" => "Special Instructions",
"SpecialNeeds" => "Special Needs",
"EnteredBy" => "Entered By",
"OrderLongDescription" => "Order Long Description",
"ApprovedDate" => "Approved Date",
"CommentNumber" => "Comment Number",
"CommentDate" => "Comment Date",
"Comment" => "Comment"];
}?>
