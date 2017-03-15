<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendorfinancials";
public $gridFields =["VendorID","BookedPurchaseOrders","CurrentAPBalance","PurchaseYTD","PaymentsYTD","LastPurchaseDate"];
public $dashboardTitle ="Vendor Financials";
public $breadCrumbTitle ="Vendor Financials";
public $idField ="VendorID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID"];
public $editCategories = [
"Main" => [

"VendorID" => [
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
"inputType" => "datetime",
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
"AvailableCredit" => [
"inputType" => "text",
"defaultValue" => ""
],
"PromptPerc" => [
"inputType" => "text",
"defaultValue" => ""
],
"BookedPurchaseOrders" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdvertisingDollars" => [
"inputType" => "text",
"defaultValue" => ""
],
"TotalAP" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrentAPBalance" => [
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
"LastPurchaseDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"PurchaseYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseLifetime" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentsYTD" => [
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
"DebitMemos" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastDebitMemoDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"DebitMemosYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"DebitMemosLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"DebitMemosLifetime" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorReturns" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastReturnDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ReturnsYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReturnsLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReturnsLifetime" => [
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
