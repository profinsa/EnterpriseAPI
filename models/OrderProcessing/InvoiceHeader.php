<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "invoiceheader"
;protected $gridFields =["InvoiceNumber","OrderNumber","TransactionTypeID","InvoiceDate","CustomerID","CurrencyID","Total","ShipDate"];
public $dashboardTitle ="Invoices";
public $breadCrumbTitle ="Invoices";
public $idField ="InvoiceNumber";
public $editCategories = [];
public $columnNames = [

"InvoiceNumber" => "Invoice Number",
"OrderNumber" => "Order Number",
"TransactionTypeID" => "Type",
"InvoiceDate" => "Invoice Date",
"CustomerID" => "Customer ID",
"CurrencyID" => "Currency ID",
"Total" => "Total",
"ShipDate" => "Ship Date"];
}?>
