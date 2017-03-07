<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "orderheaderhistory"
;protected $gridFields =["OrderNumber","OrderTypeID","OrderDate","CustomerID","CurrencyID","Total","ShipDate","Invoiced"];
public $dashboardTitle ="Orders History";
public $breadCrumbTitle ="Orders History";
public $idField ="OrderNumber";
public $editCategories = [];
public $columnNames = [

"OrderNumber" => "Order Number",
"OrderTypeID" => "Type",
"OrderDate" => "Order Date",
"CustomerID" => "Customer ID",
"CurrencyID" => "CurrencyID",
"Total" => "Total",
"ShipDate" => "Ship Date",
"Invoiced" => "Invoiced"];
}?>
