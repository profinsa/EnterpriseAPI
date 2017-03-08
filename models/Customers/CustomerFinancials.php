<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customerfinancials";
protected $gridFields =["CustomerID","BookedOrders","CurrentARBalance","SalesYTD","PaymentsYTD","InvoicesYTD","LastSalesDate"];
public $dashboardTitle ="Customer Financials";
public $breadCrumbTitle ="Customer Financials";
public $idField ="CustomerID";
public $editCategories = [
"Main" => [

"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AvailibleCredit" => [
"inputType" => "text",
"defaultValue" => ""
],
"LateDays" => [
"inputType" => "text",
"defaultValue" => ""
],
"AverageDaytoPay" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastPaymentDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastPaymentAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"HighestCredit" => [
"inputType" => "text",
"defaultValue" => ""
],
"HighestBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"PromptPerc" => [
"inputType" => "text",
"defaultValue" => ""
],
"BookedOrders" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdvertisingDollars" => [
"inputType" => "text",
"defaultValue" => ""
],
"TotalAR" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrentARBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"Under30" => [
"inputType" => "text",
"defaultValue" => ""
],
"Over30" => [
"inputType" => "text",
"defaultValue" => ""
],
"Over60" => [
"inputType" => "text",
"defaultValue" => ""
],
"Over90" => [
"inputType" => "text",
"defaultValue" => ""
],
"Over120" => [
"inputType" => "text",
"defaultValue" => ""
],
"Over150" => [
"inputType" => "text",
"defaultValue" => ""
],
"Over180" => [
"inputType" => "text",
"defaultValue" => ""
],
"SalesYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"SalesLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"SalesLifetime" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastSalesDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentsLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentsLifetime" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentsYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"WriteOffsYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"WriteOffsLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"WriteOffsLifetime" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoicesYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoicesLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoicesLifetime" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditMemos" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastCreditMemoDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditMemosYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditMemosLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditMemosLifetime" => [
"inputType" => "text",
"defaultValue" => ""
],
"RMAs" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastRMADate" => [
"inputType" => "text",
"defaultValue" => ""
],
"RMAsYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"RMAsLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"RMAsLifetime" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"BookedOrders" => "Booked Orders",
"CurrentARBalance" => "Current AR Balance",
"SalesYTD" => "Sales YTD",
"PaymentsYTD" => "Payments YTD",
"InvoicesYTD" => "Invoices YTD",
"LastSalesDate" => "Last Sales Date",
"AvailibleCredit" => "Available Credit",
"AverageDaytoPay" => "Average Days",
"LateDays" => "Late Days",
"LastPaymentDate" => "Last Payment Date",
"LastPaymentAmount" => "Last Payment Amount",
"PromptPerc" => "Prompt Perc",
"HighestCredit" => "Highest Credit",
"HighestBalance" => "Highest Balance",
"AdvertisingDollars" => "Advertising Dollars",
"TotalAR" => "Total AR",
"Under30" => "Under 30",
"Over30" => "Over 30",
"Over60" => "Over 60",
"Over90" => "Over 90",
"Over120" => "Over 120",
"Over150" => "Over 150",
"Over180" => "Over 180",
"SalesLastYear" => "Sales Last Year",
"SalesLifetime" => "Sales Lifetime",
"PaymentsLastYear" => "Payments Last Year",
"PaymentsLifetime" => "Payments Lifetime",
"WriteOffsYTD" => "Write Offs YTD",
"WriteOffsLastYear" => "Write Offs Last Year",
"WriteOffsLifetime" => "Write Offs Lifetime",
"InvoicesLastYear" => "Invoices Last Year",
"InvoicesLifetime" => "Invoices Lifetime",
"CreditMemos" => "Credit Memos",
"LastCreditMemoDate" => "Last Credit Memo Date",
"CreditMemosYTD" => "Credit Memos YTD",
"CreditMemosLastYear" => "Credit Memos Last Year",
"CreditMemosLifetime" => "Credit Memos Lifetime",
"RMAs" => "RMAs",
"LastRMADate" => "Last RMA Date",
"RMAsYTD" => "RMAs YTD",
"RMAsLastYear" => "RMAs Last Year",
"RMAsLifetime" => "RMAs Lifetime"];
}?>
