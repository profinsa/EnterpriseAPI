<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehouses";
public $dashboardTitle ="Warehouses";
public $breadCrumbTitle ="Warehouses";
public $idField ="WarehouseID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WarehouseID"];
public $gridFields = [

"WarehouseID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WarehouseName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"WarehousePhone" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WarehouseID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseAddress3" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseZip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehousePhone" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseFax" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseEmail" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseWebPage" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseAttention" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"RoutingContactName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"RoutingAddressd" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"RoutingContactPhone" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"RoutingContactFax" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"RoutingContactEmail" => [
"dbType" => "varchar(50)",
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
