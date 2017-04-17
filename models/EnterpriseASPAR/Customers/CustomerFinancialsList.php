<?php

/*
Name of Page: CustomerFinancialsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Customers\CustomerFinancialsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/CustomerFinancialsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Customers\CustomerFinancialsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Customers\CustomerFinancialsList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
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
    "format" => "{0:n}",
    "inputType" => "text"
],
"CurrentARBalance" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"SalesYTD" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"PaymentsYTD" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"InvoicesYTD" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"LastSalesDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
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
"AvailibleCredit" => "Availible Credit",
"LateDays" => "Late Days",
"AverageDaytoPay" => "Average Day to Pay",
"LastPaymentDate" => "Last Payment Date",
"LastPaymentAmount" => "Last Payment Amount",
"HighestCredit" => "Highest Credit",
"HighestBalance" => "Highest Balance",
"PromptPerc" => "Prompt Perc",
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
