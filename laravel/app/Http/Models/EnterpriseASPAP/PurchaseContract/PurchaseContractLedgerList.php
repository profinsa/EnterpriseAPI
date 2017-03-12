<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "purchasecontractledger";
protected $gridFields =["PurchaseOrderLineNumber","NumberUsed","DateUsed"];
public $dashboardTitle ="PurchaseContractLedger";
public $breadCrumbTitle ="PurchaseContractLedger";
public $idField ="PurchaseContractNumber";
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
"inputType" => "datepicker",
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
