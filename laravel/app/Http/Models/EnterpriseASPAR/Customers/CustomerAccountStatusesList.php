<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customeraccountstatuses";
public $dashboardTitle ="Customer Account Statuses";
public $breadCrumbTitle ="Customer Account Statuses";
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

"AccountStatus" => "Account Status ID",
"AccountStatusDescription" => "Account Status Description"];
}?>
