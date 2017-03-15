<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendoraccountstatuses";
public $dashboardTitle ="Vendor Account Statuses";
public $breadCrumbTitle ="Vendor Account Statuses";
public $idField ="AccountStatus";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AccountStatus"];
public $gridFields = [

"AccountStatus" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AccountStatusDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"AccountStatus" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AccountStatusDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AccountStatus" => "Account Status",
"AccountStatusDescription" => "Account Status Description"];
}?>
