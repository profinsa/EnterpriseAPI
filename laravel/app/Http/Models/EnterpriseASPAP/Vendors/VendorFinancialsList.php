<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendorfinancials";
public $dashboardTitle ="Vendor Financials";
public $breadCrumbTitle ="Vendor Financials";
public $idField ="VendorID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID"];
public $gridFields = [

"VendorID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"BookedPurchaseOrders" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"CurrentAPBalance" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"PurchaseYTD" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"PaymentsYTD" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"LastPurchaseDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"VendorID" => [
"dbType" => "varchar(50)",
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
"AvailableCredit" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"PromptPerc" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"BookedPurchaseOrders" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"AdvertisingDollars" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"TotalAP" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrentAPBalance" => [
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
"LastPurchaseDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PurchaseYTD" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseLastYear" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseLifetime" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentsYTD" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
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
"DebitMemos" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"LastDebitMemoDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"DebitMemosYTD" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"DebitMemosLastYear" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"DebitMemosLifetime" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"VendorReturns" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"LastReturnDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ReturnsYTD" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ReturnsLastYear" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ReturnsLifetime" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"VendorID" => "Vendor ID",
"BookedPurchaseOrders" => "Booked Orders",
"CurrentAPBalance" => "AP Balance",
"PurchaseYTD" => "Purchase YTD",
"PaymentsYTD" => "Payments YTD",
"LastPurchaseDate" => "Last Purchase Date",
"LateDays" => "LateDays",
"AverageDaytoPay" => "AverageDaytoPay",
"LastPaymentDate" => "LastPaymentDate",
"LastPaymentAmount" => "LastPaymentAmount",
"HighestCredit" => "HighestCredit",
"HighestBalance" => "HighestBalance",
"AvailableCredit" => "AvailableCredit",
"PromptPerc" => "PromptPerc",
"AdvertisingDollars" => "AdvertisingDollars",
"TotalAP" => "TotalAP",
"Under30" => "Under30",
"Over30" => "Over30",
"Over60" => "Over60",
"Over90" => "Over90",
"Over120" => "Over120",
"Over150" => "Over150",
"Over180" => "Over180",
"PurchaseLastYear" => "PurchaseLastYear",
"PurchaseLifetime" => "PurchaseLifetime",
"PaymentsLastYear" => "PaymentsLastYear",
"PaymentsLifetime" => "PaymentsLifetime",
"DebitMemos" => "DebitMemos",
"LastDebitMemoDate" => "LastDebitMemoDate",
"DebitMemosYTD" => "DebitMemosYTD",
"DebitMemosLastYear" => "DebitMemosLastYear",
"DebitMemosLifetime" => "DebitMemosLifetime",
"VendorReturns" => "VendorReturns",
"LastReturnDate" => "LastReturnDate",
"ReturnsYTD" => "ReturnsYTD",
"ReturnsLastYear" => "ReturnsLastYear",
"ReturnsLifetime" => "ReturnsLifetime"];
}?>
