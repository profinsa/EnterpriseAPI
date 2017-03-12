<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "paymentsheader";
protected $gridFields =["PaymentID","PaymentTypeID","CheckNumber","VendorID","InvoiceNumber","PaymentDate","CurrencyID","Amount","Cleared","Posted","Reconciled"];
public $dashboardTitle ="Closed Payments";
public $breadCrumbTitle ="Closed Payments";
public $idField ="PaymentID";
public $editCategories = [
"Main" => [

"PaymentID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CheckNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"CheckPrinted" => [
"inputType" => "text",
"defaultValue" => ""
],
"CheckDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"Paid" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"Memorize" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentClassID" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorID" => [
"inputType" => "text",
"defaultValue" => ""
],
"SystemDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"DueToDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"PurchaseDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"Amount" => [
"inputType" => "text",
"defaultValue" => ""
],
"UnAppliedAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBankAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentStatus" => [
"inputType" => "text",
"defaultValue" => ""
],
"Void" => [
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
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
"CreditAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"SelectedForPayment" => [
"inputType" => "text",
"defaultValue" => ""
],
"SelectedForPaymentDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"ApprovedForPayment" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedForPaymentDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"Cleared" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"Posted" => [
"inputType" => "text",
"defaultValue" => ""
],
"Reconciled" => [
"inputType" => "text",
"defaultValue" => ""
],
"Credit" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
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
"VendorInvoiceNumber" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PaymentID" => "Payment ID",
"PaymentTypeID" => "Payment Type",
"CheckNumber" => "Check Number",
"VendorID" => "Vendor ID",
"InvoiceNumber" => "Invoice Number",
"PaymentDate" => "Payment Date",
"CurrencyID" => "Currency ID",
"Amount" => "Amount",
"Cleared" => "Cleared",
"Posted" => "Posted",
"Reconciled" => "Reconciled",
"CheckPrinted" => "CheckPrinted",
"CheckDate" => "CheckDate",
"Paid" => "Paid",
"Memorize" => "Memorize",
"PaymentClassID" => "PaymentClassID",
"SystemDate" => "SystemDate",
"DueToDate" => "DueToDate",
"PurchaseDate" => "PurchaseDate",
"UnAppliedAmount" => "UnAppliedAmount",
"GLBankAccount" => "GLBankAccount",
"PaymentStatus" => "PaymentStatus",
"Void" => "Void",
"Notes" => "Notes",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"CreditAmount" => "CreditAmount",
"SelectedForPayment" => "SelectedForPayment",
"SelectedForPaymentDate" => "SelectedForPaymentDate",
"ApprovedForPayment" => "ApprovedForPayment",
"ApprovedForPaymentDate" => "ApprovedForPaymentDate",
"Credit" => "Credit",
"ApprovedBy" => "ApprovedBy",
"EnteredBy" => "EnteredBy",
"BatchControlNumber" => "BatchControlNumber",
"BatchControlTotal" => "BatchControlTotal",
"Signature" => "Signature",
"SignaturePassword" => "SignaturePassword",
"SupervisorSignature" => "SupervisorSignature",
"SupervisorPassword" => "SupervisorPassword",
"ManagerSignature" => "ManagerSignature",
"ManagerPassword" => "ManagerPassword",
"VendorInvoiceNumber" => "VendorInvoiceNumber"];
}?>
