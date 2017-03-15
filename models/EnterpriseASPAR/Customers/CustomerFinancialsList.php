<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customerfinancials";
protected $gridFields =["CustomerID","BookedOrders","CurrentARBalance","SalesYTD","PaymentsYTD","InvoicesYTD","LastSalesDate"];
public $dashboardTitle ="Customer Financials";
public $breadCrumbTitle ="Customer Financials";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID"];
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
"inputType" => "datepicker",
"defaultValue" => "now"
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
"inputType" => "datepicker",
"defaultValue" => "now"
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
"inputType" => "datepicker",
"defaultValue" => "now"
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
"inputType" => "datepicker",
"defaultValue" => "now"
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
"CurrentARBalance" => "AR Balance",
"SalesYTD" => "Sales YTD",
"PaymentsYTD" => "Payments YTD",
"InvoicesYTD" => "Invoices YTD",
"LastSalesDate" => "Last Sales Date",
"AvailibleCredit" => "AvailibleCredit",
"LateDays" => "LateDays",
"AverageDaytoPay" => "AverageDaytoPay",
"LastPaymentDate" => "LastPaymentDate",
"LastPaymentAmount" => "LastPaymentAmount",
"HighestCredit" => "HighestCredit",
"HighestBalance" => "HighestBalance",
"PromptPerc" => "PromptPerc",
"AdvertisingDollars" => "AdvertisingDollars",
"TotalAR" => "TotalAR",
"Under30" => "Under30",
"Over30" => "Over30",
"Over60" => "Over60",
"Over90" => "Over90",
"Over120" => "Over120",
"Over150" => "Over150",
"Over180" => "Over180",
"SalesLastYear" => "SalesLastYear",
"SalesLifetime" => "SalesLifetime",
"PaymentsLastYear" => "PaymentsLastYear",
"PaymentsLifetime" => "PaymentsLifetime",
"WriteOffsYTD" => "WriteOffsYTD",
"WriteOffsLastYear" => "WriteOffsLastYear",
"WriteOffsLifetime" => "WriteOffsLifetime",
"InvoicesLastYear" => "InvoicesLastYear",
"InvoicesLifetime" => "InvoicesLifetime",
"CreditMemos" => "CreditMemos",
"LastCreditMemoDate" => "LastCreditMemoDate",
"CreditMemosYTD" => "CreditMemosYTD",
"CreditMemosLastYear" => "CreditMemosLastYear",
"CreditMemosLifetime" => "CreditMemosLifetime",
"RMAs" => "RMAs",
"LastRMADate" => "LastRMADate",
"RMAsYTD" => "RMAsYTD",
"RMAsLastYear" => "RMAsLastYear",
"RMAsLifetime" => "RMAsLifetime"];
}?>
