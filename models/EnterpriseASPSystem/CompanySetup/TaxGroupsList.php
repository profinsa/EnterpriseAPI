<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "taxgroups";
public $dashboardTitle ="Tax Groups";
public $breadCrumbTitle ="Tax Groups";
public $idField ="TaxGroupID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TaxGroupID"];
public $gridFields = [

"TaxGroupID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TotalPercent" => [
    "dbType" => "float",
    "format" => "{0:#.####}",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TaxGroupID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxGroupDetailID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TotalPercent" => [
"dbType" => "float",
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

"TaxGroupID" => "Tax Group ID",
"TotalPercent" => "Total Percent",
"TaxGroupDetailID" => "TaxGroupDetailID",
"TaxOnTax" => "TaxOnTax"];
}?>
