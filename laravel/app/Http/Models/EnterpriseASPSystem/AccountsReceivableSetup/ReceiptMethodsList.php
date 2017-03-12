<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "receiptmethods";
protected $gridFields =["ReceiptMethodID","ReceiptMethodDescription"];
public $dashboardTitle ="ReceiptMethods";
public $breadCrumbTitle ="ReceiptMethods";
public $idField ="ReceiptMethodID";
public $editCategories = [
"Main" => [

"ReceiptMethodID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReceiptMethodDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ReceiptMethodID" => "Receipt Method ID",
"ReceiptMethodDescription" => "Receipt Method Description"];
}?>
