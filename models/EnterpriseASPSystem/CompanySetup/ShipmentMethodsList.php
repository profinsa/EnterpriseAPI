<?php

/*
Name of Page: ShipmentMethodsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\ShipmentMethodsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ShipmentMethodsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\ShipmentMethodsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\ShipmentMethodsList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class ShipmentMethodsList extends gridDataSource{
public $tableName = "shipmentmethods";
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
"FreighPayment" => "Freigh Payment",
"SCACCode" => "SCAC Code",
"SCACDescription" => "SCAC Description",
"ShippingLogin" => "Shipping Log in",
"ShippingPassword" => "Shipping Password"];
}?>
