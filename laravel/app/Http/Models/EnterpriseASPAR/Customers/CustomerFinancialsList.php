<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customerfinancials";
public $dashboardTitle ="Customer Financials";
public $breadCrumbTitle ="Customer Financials";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID"];
public $gridFields = [

"CustomerID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"BookedOrders" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"CurrentARBalance" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"SalesYTD" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"PaymentsYTD" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"InvoicesYTD" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"LastSalesDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"CustomerID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"AvailibleCredit" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"LateDays" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
],
"AverageDaytoPay" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
],
"LastPaymentDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"LastPaymentAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"HighestCredit" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"HighestBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"PromptPerc" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"BookedOrders" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"AdvertisingDollars" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"TotalAR" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrentARBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Under30" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Over30" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Over60" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Over90" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Over120" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Over150" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Over180" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"SalesYTD" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"SalesLastYear" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"SalesLifetime" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"LastSalesDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PaymentsLastYear" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentsLifetime" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentsYTD" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"WriteOffsYTD" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"WriteOffsLastYear" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"WriteOffsLifetime" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"InvoicesYTD" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"InvoicesLastYear" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"InvoicesLifetime" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"CreditMemos" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"LastCreditMemoDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CreditMemosYTD" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"CreditMemosLastYear" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"CreditMemosLifetime" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"RMAs" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"LastRMADate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"RMAsYTD" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"RMAsLastYear" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"RMAsLifetime" => [
"dbType" => "decimal(19,4)",
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
