<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contractsheader"
;protected $gridFields =["OrderNumber","TransactionType","ContractTypeID","ContractStartDate","ContractEndDate","CurrencyID","Total","CustomerID"];
public $dashboardTitle ="Contracts";
public $breadCrumbTitle ="Contracts";
public $idField ="OrderNumber";
public $editCategories = [];
public $columnNames = [

"OrderNumber" => "Contract Number",
"TransactionType" => "Transaction Type",
"ContractTypeID" => "Contract Type",
"ContractStartDate" => "Start Date",
"ContractEndDate" => "End Date",
"CurrencyID" => "Currency ID",
"Total" => "Total",
"CustomerID" => "Customer ID"];
}?>
