<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehousebintypes";
protected $gridFields =["WarehouseBinTypeID","WarehouseBinTypeDescription"];
public $dashboardTitle ="WarehouseBinTypes";
public $breadCrumbTitle ="WarehouseBinTypes";
public $idField ="WarehouseBinTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WarehouseBinTypeID"];
public $editCategories = [
"Main" => [

"WarehouseBinTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WarehouseBinTypeID" => "Warehouse Bin Type ID",
"WarehouseBinTypeDescription" => "Warehouse Bin Type Description"];
}?>
