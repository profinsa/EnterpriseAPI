<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "taxgroupdetail";
protected $gridFields =["TaxGroupDetailID","TotalPercent"];
public $dashboardTitle ="Tax Group";
public $breadCrumbTitle ="Tax Group";
public $idField ="TaxGroupDetailID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TaxGroupDetailID"];
public $editCategories = [
"Main" => [

"TaxGroupDetailID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxID" => [
"inputType" => "text",
"defaultValue" => ""
],
"Description" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLTaxAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxPercent" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxOrder" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxOnTax" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"TaxGroupDetailID" => "Tax Group Detail ID",
"TotalPercent" => "Total Percent",
"TaxID" => "TaxID",
"Description" => "Description",
"GLTaxAccount" => "GLTaxAccount",
"TaxPercent" => "TaxPercent",
"TaxOrder" => "TaxOrder",
"TaxOnTax" => "TaxOnTax"];
}?>
