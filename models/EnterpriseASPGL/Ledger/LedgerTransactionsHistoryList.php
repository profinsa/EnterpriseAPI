<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgertransactionshistory";
public $dashboardTitle ="Ledger Transactions History";
public $breadCrumbTitle ="Ledger Transactions History";
public $idField ="GLTransactionNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","GLTransactionNumber"];
public $gridFields = [

"GLTransactionNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLTransactionTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLTransactionDate" => [
    "dbType" => "timestamp",
    "inputType" => "datetime"
],
"GLTransactionDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CurrencyID" => [
    "dbType" => "varchar(3)",
    "inputType" => "text"
],
"GLTransactionAmount" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"GLTransactionBalance" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"GLTransactionPostedYN" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"GLTransactionNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"SystemDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"GLTransactionDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionReference" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"dbType" => "varchar(3)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionAmountUndistributed" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionPostedYN" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionSource" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionSystemGenerated" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionRecurringYN" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Reversal" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"BatchControlNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"BatchControlTotal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Signature" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SignaturePassword" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorSignature" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorPassword" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ManagerSignature" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ManagerPassword" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Memorize" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"GLTransactionNumber" => "Transaction Number",
"GLTransactionTypeID" => "Type",
"GLTransactionDate" => "Date",
"GLTransactionDescription" => "Description",
"CurrencyID" => "Currency",
"GLTransactionAmount" => "Amount",
"GLTransactionBalance" => "Balance",
"GLTransactionPostedYN" => "Posted YN",
"SystemDate" => "SystemDate",
"GLTransactionReference" => "GLTransactionReference",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"GLTransactionAmountUndistributed" => "GLTransactionAmountUndistributed",
"GLTransactionSource" => "GLTransactionSource",
"GLTransactionSystemGenerated" => "GLTransactionSystemGenerated",
"GLTransactionRecurringYN" => "GLTransactionRecurringYN",
"Reversal" => "Reversal",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"EnteredBy" => "EnteredBy",
"BatchControlNumber" => "BatchControlNumber",
"BatchControlTotal" => "BatchControlTotal",
"Signature" => "Signature",
"SignaturePassword" => "SignaturePassword",
"SupervisorSignature" => "SupervisorSignature",
"SupervisorPassword" => "SupervisorPassword",
"ManagerSignature" => "ManagerSignature",
"ManagerPassword" => "ManagerPassword",
"Memorize" => "Memorize"];
}?>
