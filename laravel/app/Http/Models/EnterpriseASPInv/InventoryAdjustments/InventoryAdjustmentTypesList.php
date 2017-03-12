<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryadjustmenttypes";
protected $gridFields =["AdjustmentTypeID","AdjustmentTypeDescription"];
public $dashboardTitle ="Inventory Adjustment Types";
public $breadCrumbTitle ="Inventory Adjustment Types";
public $idField ="AdjustmentTypeID";
public $editCategories = [
"Main" => [

"AdjustmentTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AdjustmentTypeID" => "Adjustment Type ID",
"AdjustmentTypeDescription" => "Adjustment Type Description"];
}?>
