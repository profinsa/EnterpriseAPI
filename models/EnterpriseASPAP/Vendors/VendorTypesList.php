<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendortypes";
protected $gridFields =["VendorTypeID","VendorTypeDescription"];
public $dashboardTitle ="Vendor Types";
public $breadCrumbTitle ="Vendor Types";
public $idField ="VendorTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorTypeID"];
public $editCategories = [
"Main" => [

"VendorTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"VendorTypeID" => "Vendor Type ID",
"VendorTypeDescription" => "Vendor Type Description"];
}?>
