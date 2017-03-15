<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "shipmentmethods";
public $dashboardTitle ="Shipment Methods";
public $breadCrumbTitle ="Shipment Methods";
public $idField ="ShipMethodID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ShipMethodID"];
public $gridFields = [

"ShipMethodID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ShipMethodDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ShippingAccountNumber" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"WebsiteUrl" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ShipMethodID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipMethodDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"FreighPayment" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"SCACCode" => [
"dbType" => "varchar(4)",
"inputType" => "text",
"defaultValue" => ""
],
"SCACDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShippingAccountNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShippingLogin" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"ShippingPassword" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"WebsiteUrl" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ShipMethodID" => "Ship Method ID",
"ShipMethodDescription" => "Ship Method Description",
"ShippingAccountNumber" => "Shipping Account Number",
"WebsiteUrl" => "Website Url",
"FreighPayment" => "FreighPayment",
"SCACCode" => "SCACCode",
"SCACDescription" => "SCACDescription",
"ShippingLogin" => "ShippingLogin",
"ShippingPassword" => "ShippingPassword"];
}?>
