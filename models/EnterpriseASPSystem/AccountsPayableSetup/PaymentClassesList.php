<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "paymentclasses";
public $dashboardTitle ="Payment Classes";
public $breadCrumbTitle ="Payment Classes";
public $idField ="PaymentClassID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentClassID"];
public $gridFields = [

"PaymentClassID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PaymentClassesDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PaymentClassID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentClassesDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PaymentClassID" => "Payment Class ID",
"PaymentClassesDescription" => "Payment Classes Description"];
}?>
