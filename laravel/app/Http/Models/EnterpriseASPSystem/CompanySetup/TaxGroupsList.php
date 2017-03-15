<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "taxgroups";
public $gridFields =["TaxGroupID","TotalPercent"];
public $dashboardTitle ="Tax Groups";
public $breadCrumbTitle ="Tax Groups";
public $idField ="TaxGroupID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TaxGroupID"];
public $editCategories = [
"Main" => [

"TaxGroupID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxGroupDetailID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TotalPercent" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxOnTax" => [
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
