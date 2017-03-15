<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "paymentmethods";
public $gridFields =["PaymentMethodID","PaymentMethodDescription"];
public $dashboardTitle ="Payment Methods";
public $breadCrumbTitle ="Payment Methods";
public $idField ="PaymentMethodID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentMethodID"];
public $editCategories = [
"Main" => [

"PaymentMethodID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentMethodDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PaymentMethodID" => "Payment Method ID",
"PaymentMethodDescription" => "Payment Method Description"];
}?>
