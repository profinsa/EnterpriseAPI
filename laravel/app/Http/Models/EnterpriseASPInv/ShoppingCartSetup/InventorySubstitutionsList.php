<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorysubstitutions";
protected $gridFields =["ItemID","SubstituteItemID"];
public $dashboardTitle ="InventorySubstitutions";
public $breadCrumbTitle ="InventorySubstitutions";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $editCategories = [
"Main" => [

"ItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"SubstituteItemID" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"SubstituteItemID" => "Substitute Item ID"];
}?>
