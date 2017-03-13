<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "creditcardtypes";
protected $gridFields =["CreditCardTypeID","CreditCardDescription"];
public $dashboardTitle ="Credit Card Types";
public $breadCrumbTitle ="Credit Card Types";
public $idField ="CreditCardTypeID";
public $editCategories = [
"Main" => [

"CreditCardTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CreditCardTypeID" => "Credit Card Type ID",
"CreditCardDescription" => "Credit Card Description"];
}?>