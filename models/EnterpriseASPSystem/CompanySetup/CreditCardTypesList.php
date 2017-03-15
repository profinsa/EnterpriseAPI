<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "creditcardtypes";
public $dashboardTitle ="Credit Card Types";
public $breadCrumbTitle ="Credit Card Types";
public $idField ="CreditCardTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CreditCardTypeID"];
public $gridFields = [

"CreditCardTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CreditCardDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"CreditCardTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CreditCardTypeID" => "Credit Card Type ID",
"CreditCardDescription" => "Credit Card Description"];
}?>
