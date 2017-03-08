<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customeraccountstatuses";
protected $gridFields =["AccountStatus","AccountStatusDescription"];
public $dashboardTitle ="Customer Account Statuses";
public $breadCrumbTitle ="Customer Account Statuses";
public $idField ="AccountStatus";
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

"AccountStatus" => "Account Status",
"AccountStatusDescription" => "Account Status Description"];
}?>
