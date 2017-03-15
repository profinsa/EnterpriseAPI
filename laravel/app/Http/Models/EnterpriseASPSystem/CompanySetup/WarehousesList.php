<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehouses";
public $gridFields =["WarehouseID","WarehouseName","WarehousePhone"];
public $dashboardTitle ="Warehouses";
public $breadCrumbTitle ="Warehouses";
public $idField ="WarehouseID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WarehouseID"];
public $editCategories = [
"Main" => [

"WarehouseID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseName" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseAddress3" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseState" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehousePhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseWebPage" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseAttention" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingContactName" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingAddressd" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingContactPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingContactFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingContactEmail" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WarehouseID" => "Warehouse ID",
"WarehouseName" => "Warehouse Name",
"WarehousePhone" => "Warehouse Phone",
"WarehouseAddress1" => "WarehouseAddress1",
"WarehouseAddress2" => "WarehouseAddress2",
"WarehouseAddress3" => "WarehouseAddress3",
"WarehouseCity" => "WarehouseCity",
"WarehouseState" => "WarehouseState",
"WarehouseZip" => "WarehouseZip",
"WarehouseFax" => "WarehouseFax",
"WarehouseEmail" => "WarehouseEmail",
"WarehouseWebPage" => "WarehouseWebPage",
"WarehouseAttention" => "WarehouseAttention",
"RoutingContactName" => "RoutingContactName",
"RoutingAddressd" => "RoutingAddressd",
"RoutingContactPhone" => "RoutingContactPhone",
"RoutingContactFax" => "RoutingContactFax",
"RoutingContactEmail" => "RoutingContactEmail"];
}?>
