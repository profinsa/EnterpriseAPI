<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgertransactions";
protected $gridFields =["GLTransactionNumber","GLTransactionTypeID","GLTransactionDate","GLTransactionDescription","CurrencyID","GLTransactionAmount","GLTransactionBalance","GLTransactionPostedYN"];
public $dashboardTitle ="Closed Ledger Transactions";
public $breadCrumbTitle ="Closed Ledger Transactions";
public $idField ="GLTransactionNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","GLTransactionNumber"];
public $editCategories = [
"Main" => [

"GLTransactionNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"SystemDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"GLTransactionDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionReference" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionAmountUndistributed" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionPostedYN" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionSource" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionSystemGenerated" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLTransactionRecurringYN" => [
"inputType" => "text",
"defaultValue" => ""
],
"Reversal" => [
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
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
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
"Memorize" => [
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
