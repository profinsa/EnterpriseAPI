<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customeraccountstatuses";
public $gridFields =["AccountStatus","AccountStatusDescription"];
public $dashboardTitle ="Customer Account Statuses";
public $breadCrumbTitle ="Customer Account Statuses";
public $idField ="AccountStatus";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AccountStatus"];
public $editCategories = [
"Main" => [

"AccountStatus" => [
"inputType" => "text",
"defaultValue" => ""
],
"AccountStatusDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AccountStatus" => "Account Status ID",
"AccountStatusDescription" => "Account Status Description"];
}?>
