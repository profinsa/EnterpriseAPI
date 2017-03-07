<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "orderheader"
;protected $gridFields =["OrderNumber","OrderTypeID","OrderDate","CustomerID","CurrencyID","Total","ShipDate","Invoiced"];
public $dashboardTitle ="Service Orders";
public $breadCrumbTitle ="Service Orders";
public $idField ="OrderNumber";
public $editCategories = [];
public $columnNames = [

"OrderNumber" => "Order Number",
"OrderTypeID" => "Type",
"OrderDate" => "Order Date",
"CustomerID" => "Customer ID",
"CurrencyID" => "Currency ID",
"Total" => "Total",
"ShipDate" => "Perform Date",
"Invoiced" => "Invoiced"];
}?>
