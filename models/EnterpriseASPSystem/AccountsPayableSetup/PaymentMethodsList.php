<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "paymentmethods";
public $dashboardTitle ="Payment Methods";
public $breadCrumbTitle ="Payment Methods";
public $idField ="PaymentMethodID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentMethodID"];
public $gridFields = [

"PaymentMethodID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PaymentMethodDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PaymentMethodID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentMethodDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PaymentMethodID" => "Payment Method ID",
"PaymentMethodDescription" => "Payment Method Description"];
}?>
