<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "banktransactions";
public $dashboardTitle ="Bank Transactions";
public $breadCrumbTitle ="Bank Transactions";
public $idField ="BankTransactionID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","BankTransactionID"];
public $gridFields = [

"BankTransactionID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"BankDocumentNumber" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
],
"TransactionType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TransactionDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"TransactionAmount" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"Posted" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
],
"Cleared" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"BankTransactionID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"BankDocumentNumber" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBankAccount1" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBankAccount2" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TransactionType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TransactionDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"SystemDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
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
"TransactionAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"BeginningBalance" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Reference" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Posted" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Cleared" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
"dbType" => "varchar(255)",
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
]
]];
public $columnNames = [

"BankTransactionID" => "Transaction ID",
"BankDocumentNumber" => "Bank Document Number",
"TransactionType" => "Transaction Type",
"TransactionDate" => "Transaction Date",
"TransactionAmount" => "Transaction Amount",
"Posted" => "Posted",
"Cleared" => "Cleared",
"GLBankAccount1" => "GLBankAccount1",
"GLBankAccount2" => "GLBankAccount2",
"SystemDate" => "SystemDate",
"CurrencyID" => "CurrencyID",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"BeginningBalance" => "BeginningBalance",
"Reference" => "Reference",
"Notes" => "Notes",
"BatchControlNumber" => "BatchControlNumber",
"BatchControlTotal" => "BatchControlTotal",
"Signature" => "Signature",
"SignaturePassword" => "SignaturePassword",
"SupervisorSignature" => "SupervisorSignature",
"SupervisorPassword" => "SupervisorPassword",
"ManagerSignature" => "ManagerSignature",
"ManagerPassword" => "ManagerPassword",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"EnteredBy" => "EnteredBy"];
}?>
