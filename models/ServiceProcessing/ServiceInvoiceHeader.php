<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "invoiceheader"
;protected $gridFields =["InvoiceNumber","TransactionTypeID","InvoiceDate","CustomerID","CurrencyID","Total","ShipDate","OrderNumber"];
public $dashboardTitle ="Service Invoices";
public $breadCrumbTitle ="Service Invoices";
public $idField ="InvoiceNumber";
public $editCategories = [];
public $columnNames = [

"InvoiceNumber" => "Invoice Number",
"TransactionTypeID" => "Type",
"InvoiceDate" => "Invoice Date",
"CustomerID" => "Customer ID",
"CurrencyID" => "Currency ID",
"Total" => "Total",
"ShipDate" => "Perform Date",
"OrderNumber" => "Order Number"];
}?>
