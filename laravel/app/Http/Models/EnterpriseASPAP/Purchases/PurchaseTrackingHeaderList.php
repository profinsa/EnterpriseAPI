<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "purchasetrackingheader";
public $gridFields =["PurchaseNumber","PurchaseDescription","SpecialInstructions","SpecialNeeds","EnteredBy"];
public $dashboardTitle ="PurchaseTrackingHeader";
public $breadCrumbTitle ="PurchaseTrackingHeader";
public $idField ="PurchaseNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PurchaseNumber"];
public $editCategories = [
"Main" => [

"PurchaseNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseLongDescription" => [
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
