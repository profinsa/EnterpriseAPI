<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehousebintypes";
public $dashboardTitle ="WarehouseBinTypes";
public $breadCrumbTitle ="WarehouseBinTypes";
public $idField ="WarehouseBinTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WarehouseBinTypeID"];
public $gridFields = [

"WarehouseBinTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WarehouseBinTypeDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WarehouseBinTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinTypeDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WarehouseBinTypeID" => "Warehouse Bin Type ID",
"WarehouseBinTypeDescription" => "Warehouse Bin Type Description"];
}?>
