<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "orderheader"
;protected $gridFields =["OrderNumber","OrderTypeID","OrderDate","CustomerID","CurrencyID","Total","ShipDate","Invoiced"];
public $dashboardTitle ="Orders On Hold";
public $breadCrumbTitle ="Orders On Hold";
public $idField ="OrderNumber";
public $editCategories = [];
public $columnNames = [

"OrderNumber" => "Order Number",
"OrderTypeID" => "Type",
"OrderDate" => "Order Date",
"CustomerID" => "Customer ID",
"CurrencyID" => "Currency ID",
"Total" => "Total",
"ShipDate" => "Ship Date",
"Invoiced" => "Invoiced"];
}?>
