<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendortypes";
public $dashboardTitle ="Vendor Types";
public $breadCrumbTitle ="Vendor Types";
public $idField ="VendorTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorTypeID"];
public $gridFields = [

"VendorTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"VendorTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"VendorTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"VendorTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"VendorTypeID" => "Vendor Type ID",
"VendorTypeDescription" => "Vendor Type Description"];
}?>
