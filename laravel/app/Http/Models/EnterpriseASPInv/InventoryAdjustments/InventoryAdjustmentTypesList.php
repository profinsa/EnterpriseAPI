<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryadjustmenttypes";
public $dashboardTitle ="Inventory Adjustment Types";
public $breadCrumbTitle ="Inventory Adjustment Types";
public $idField ="AdjustmentTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AdjustmentTypeID"];
public $gridFields = [

"AdjustmentTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AdjustmentTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"AdjustmentTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AdjustmentTypeID" => "Adjustment Type ID",
"AdjustmentTypeDescription" => "Adjustment Type Description"];
}?>
