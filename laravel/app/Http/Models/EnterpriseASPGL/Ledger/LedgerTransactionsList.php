<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgertransactions";
public $dashboardTitle ="Ledger Transactions";
public $breadCrumbTitle ="Ledger Transactions";
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
    "format" => "{0:d}",
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
    "format" => "{0:n}",
    "inputType" => "text"
],
"GLTransactionBalance" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
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
"inputType" => "checkbox",
"defaultValue" => "0"
],
"GLTransactionSource" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionSystemGenerated" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"GLTransactionRecurringYN" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Reversal" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
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
"inputType" => "checkbox",
"defaultValue" => "0"
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
