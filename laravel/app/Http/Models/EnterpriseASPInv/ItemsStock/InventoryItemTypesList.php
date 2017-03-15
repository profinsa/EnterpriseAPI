<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryitemtypes";
public $gridFields =["ItemTypeID","ItemTypeDescription"];
public $dashboardTitle ="InventoryItemTypes";
public $breadCrumbTitle ="InventoryItemTypes";
public $idField ="ItemTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemTypeID"];
public $editCategories = [
"Main" => [

"ItemTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"Serialized" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ItemTypeID" => "Item Type ID",
"ItemTypeDescription" => "Item Type Description",
"Serialized" => "Serialized"];
}?>
