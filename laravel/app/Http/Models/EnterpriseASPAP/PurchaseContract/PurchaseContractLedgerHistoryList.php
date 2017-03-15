<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "purchasecontractledgerhistory";
protected $gridFields =["PurchaseOrderLineNumber","NumberUsed","DateUsed"];
public $dashboardTitle ="PurchaseContractLedgerHistory";
public $breadCrumbTitle ="PurchaseContractLedgerHistory";
public $idField ="";
public $idFields = ;
public $editCategories = [
"Main" => [

"PurchaseContractNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseOrderNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseOrderLineNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"NumberUsed" => [
"inputType" => "text",
"defaultValue" => ""
],
"DateUsed" => [
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"PurchaseOrderLineNumber" => "PO Line Number",
"NumberUsed" => "Number Used",
"DateUsed" => "Date Used",
"PurchaseContractNumber" => "PurchaseContractNumber",
"PurchaseOrderNumber" => "PurchaseOrderNumber"];
}?>
