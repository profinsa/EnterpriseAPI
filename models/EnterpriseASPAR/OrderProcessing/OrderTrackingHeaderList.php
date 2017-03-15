<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ordertrackingheader";
public $gridFields =["OrderNumber","OrderDescription","SpecialInstructions","SpecialNeeds","EnteredBy"];
public $dashboardTitle ="OrderTrackingHeader";
public $breadCrumbTitle ="OrderTrackingHeader";
public $idField ="OrderNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","OrderNumber"];
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
