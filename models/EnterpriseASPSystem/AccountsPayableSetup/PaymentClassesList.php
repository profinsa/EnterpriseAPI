<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "paymentclasses";
public $gridFields =["PaymentClassID","PaymentClassesDescription"];
public $dashboardTitle ="Payment Classes";
public $breadCrumbTitle ="Payment Classes";
public $idField ="PaymentClassID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentClassID"];
public $editCategories = [
"Main" => [

"PaymentClassID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentClassesDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PaymentClassID" => "Payment Class ID",
"PaymentClassesDescription" => "Payment Classes Description"];
}?>
