<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "taxes";
protected $gridFields =["TaxID","TaxDescription","TaxPercent","GLTaxAccount"];
public $dashboardTitle ="Taxes";
public $breadCrumbTitle ="Taxes";
public $idField ="TaxID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TaxID"];
public $editCategories = [
"Main" => [

"TaxID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxPercent" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLTaxAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxOrder" => [
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

"TaxID" => "Tax ID",
"TaxDescription" => "Tax Description",
"TaxPercent" => "Tax Percent",
"GLTaxAccount" => "GL Account",
"TaxOrder" => "TaxOrder",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"EnteredBy" => "EnteredBy"];
}?>
