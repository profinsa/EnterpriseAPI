<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "banktransactions";
protected $gridFields =["BankTransactionID","BankDocumentNumber","TransactionType","TransactionDate","TransactionAmount","Posted","Cleared"];
public $dashboardTitle ="Bank Transactions";
public $breadCrumbTitle ="Bank Transactions";
public $idField ="BankTransactionID";
public $editCategories = [
"Main" => [

"BankTransactionID" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankDocumentNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBankAccount1" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBankAccount2" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionType" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"SystemDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"BeginningBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"Reference" => [
"inputType" => "text",
"defaultValue" => ""
],
"Posted" => [
"inputType" => "text",
"defaultValue" => ""
],
"Cleared" => [
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
"inputType" => "text",
"defaultValue" => ""
],
"BatchControlNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"BatchControlTotal" => [
"inputType" => "text",
"defaultValue" => ""
],
"Signature" => [
"inputType" => "text",
"defaultValue" => ""
],
"SignaturePassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorSignature" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorPassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"ManagerSignature" => [
"inputType" => "text",
"defaultValue" => ""
],
"ManagerPassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"EnteredBy" => [
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
