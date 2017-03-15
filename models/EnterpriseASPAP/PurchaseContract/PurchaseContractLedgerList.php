<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "purchasecontractledger";
protected $gridFields =["PurchaseOrderLineNumber","NumberUsed","DateUsed"];
public $dashboardTitle ="PurchaseContractLedger";
public $breadCrumbTitle ="PurchaseContractLedger";
public $idField ="PurchaseContractNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PurchaseContractNumber","PurchaseOrderNumber","PurchaseOrderLineNumber"];
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
