<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendoraccountstatuses";
protected $gridFields =["AccountStatus","AccountStatusDescription"];
public $dashboardTitle ="Vendor Account Statuses";
public $breadCrumbTitle ="Vendor Account Statuses";
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