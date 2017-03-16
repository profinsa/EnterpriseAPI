<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "taxes";
public $dashboardTitle ="Taxes";
public $breadCrumbTitle ="Taxes";
public $idField ="TaxID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TaxID"];
public $gridFields = [

"TaxID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TaxDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TaxPercent" => [
    "dbType" => "float",
    "format" => "{0:#.####}",
    "inputType" => "text"
],
"GLTaxAccount" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TaxID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxPercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLTaxAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxOrder" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"dbType" => "varchar(36)",
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
