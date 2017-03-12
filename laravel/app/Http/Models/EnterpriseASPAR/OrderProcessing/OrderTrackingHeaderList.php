<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ordertrackingheader";
protected $gridFields =["OrderNumber","OrderDescription","SpecialInstructions","SpecialNeeds","EnteredBy"];
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
"inputType" => "datepicker",
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
