<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "taxgroupdetail";
public $dashboardTitle ="Tax Group";
public $breadCrumbTitle ="Tax Group";
public $idField ="TaxGroupDetailID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TaxGroupDetailID"];
public $gridFields = [

"TaxGroupDetailID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TaxGroupDetailID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Description" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLTaxAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxPercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"TaxOrder" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxOnTax" => [
"dbType" => "tinyint(1)",
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
