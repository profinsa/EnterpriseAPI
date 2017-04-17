<?php

/*
Name of Page: WarehousesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehousesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/WarehousesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehousesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\WarehousesList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
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
"WarehouseAddress1" => "Warehouse Address 1",
"WarehouseAddress2" => "Warehouse Address 2",
"WarehouseAddress3" => "Warehouse Address 3",
"WarehouseCity" => "Warehouse City",
"WarehouseState" => "Warehouse State",
"WarehouseZip" => "Warehouse Zip",
"WarehouseFax" => "Warehouse Fax",
"WarehouseEmail" => "Warehouse Email",
"WarehouseWebPage" => "Warehouse Web Page",
"WarehouseAttention" => "Warehouse Attention",
"RoutingContactName" => "Routing Contact Name",
"RoutingAddressd" => "Routing Addressd",
"RoutingContactPhone" => "Routing Contact Phone",
"RoutingContactFax" => "Routing Contact Fax",
"RoutingContactEmail" => "Routing Contact Email"];
}?>
