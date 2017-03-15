<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "paymenttypes";
public $gridFields =["PaymentTypeID","PaymentTypeDescription"];
public $dashboardTitle ="Payment Types";
public $breadCrumbTitle ="Payment Types";
public $idField ="PaymentTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentTypeID"];
public $editCategories = [
"Main" => [

"PaymentTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PaymentTypeID" => "Payment Type ID",
"PaymentTypeDescription" => "Payment Type Description"];
}?>
