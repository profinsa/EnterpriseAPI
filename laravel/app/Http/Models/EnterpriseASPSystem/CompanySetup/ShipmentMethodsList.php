<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "shipmentmethods";
protected $gridFields =["ShipMethodID","ShipMethodDescription","ShippingAccountNumber","WebsiteUrl"];
public $dashboardTitle ="Shipment Methods";
public $breadCrumbTitle ="Shipment Methods";
public $idField ="ShipMethodID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ShipMethodID"];
public $editCategories = [
"Main" => [

"ShipMethodID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipMethodDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"FreighPayment" => [
"inputType" => "text",
"defaultValue" => ""
],
"SCACCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"SCACDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShippingAccountNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShippingLogin" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShippingPassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"WebsiteUrl" => [
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
