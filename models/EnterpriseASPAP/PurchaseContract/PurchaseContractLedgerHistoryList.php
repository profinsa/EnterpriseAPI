<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "purchasecontractledgerhistory";
public $dashboardTitle ="PurchaseContractLedgerHistory";
public $breadCrumbTitle ="PurchaseContractLedgerHistory";
public $idField ="";
public $idFields = ;
public $gridFields = [

"PurchaseOrderLineNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"NumberUsed" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"DateUsed" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"PurchaseContractNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseOrderNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseOrderLineNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"NumberUsed" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"DateUsed" => [
"dbType" => "datetime",
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
