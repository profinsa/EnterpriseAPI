<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "taxes";
protected $gridFields =["TaxID","TaxDescription","TaxPercent","GLTaxAccount"];
public $dashboardTitle ="Taxes";
public $breadCrumbTitle ="Taxes";
public $idField ="TaxID";
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
"inputType" => "datepicker",
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
