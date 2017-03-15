<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "paymenttypes";
public $dashboardTitle ="Payment Types";
public $breadCrumbTitle ="Payment Types";
public $idField ="PaymentTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentTypeID"];
public $gridFields = [

"PaymentTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PaymentTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PaymentTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PaymentTypeID" => "Payment Type ID",
"PaymentTypeDescription" => "Payment Type Description"];
}?>
