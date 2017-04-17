<?php

/*
Name of Page: WarehouseBinsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehouseBinsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/WarehouseBinsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehouseBinsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehouseBinsList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehousebins";
public $dashboardTitle ="WarehouseBins";
public $breadCrumbTitle ="WarehouseBins";
public $idField ="WarehouseID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WarehouseID","WarehouseBinID"];
public $gridFields = [

"WarehouseID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WarehouseBinID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WarehouseBinName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"WarehouseBinNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ResponsiblePerson" => [
    "dbType" => "varchar(36)",
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
"WarehouseBinID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinZone" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLocation" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLocationX" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLocationY" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLocationZ" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinLength" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinWidth" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinHeight" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinWeight" => [
"dbType" => "bigint(20)",
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseBinRFID" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"MinimumQuantity" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"MaximumQuantity" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"OverFlowBin" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"LockerStock" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"LockerStockQty" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"ResponsiblePerson" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WarehouseID" => "Warehouse ID",
"WarehouseBinID" => "Warehouse Bin ID",
"WarehouseBinName" => "Warehouse Bin Name",
"WarehouseBinNumber" => "Warehouse Bin Number",
"ResponsiblePerson" => "Responsible Person",
"WarehouseBinZone" => "Warehouse Bin Zone",
"WarehouseBinType" => "Warehouse Bin Type",
"WarehouseBinLocation" => "Warehouse Bin Location",
"WarehouseBinLocationX" => "Warehouse Bin Location X",
"WarehouseBinLocationY" => "Warehouse Bin Location Y",
"WarehouseBinLocationZ" => "Warehouse Bin Location Z",
"WarehouseBinLength" => "Warehouse Bin Length",
"WarehouseBinWidth" => "Warehouse Bin Width",
"WarehouseBinHeight" => "Warehouse Bin Height",
"WarehouseBinWeight" => "Warehouse Bin Weight",
"WarehouseBinRFID" => "Warehouse Bin RFID",
"MinimumQuantity" => "Minimum Quantity",
"MaximumQuantity" => "Maximum Quantity",
"OverFlowBin" => "Over Flow Bin",
"LockerStock" => "Locker Stock",
"LockerStockQty" => "Locker Stock Qty"];
}?>
