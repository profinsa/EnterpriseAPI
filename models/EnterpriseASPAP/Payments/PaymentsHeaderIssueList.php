<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "paymentsheader";
public $dashboardTitle ="Issue Payments";
public $breadCrumbTitle ="Issue Payments";
public $idField ="PaymentID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentID"];
public $gridFields = [

"PaymentID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"InvoiceNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PaymentTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CheckNumber" => [
    "dbType" => "varchar(20)",
    "inputType" => "text"
],
"VendorID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"PaymentDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"CurrencyID" => [
    "dbType" => "varchar(3)",
    "inputType" => "text"
],
"Cleared" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
],
"Posted" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
],
"Reconciled" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PaymentID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CheckNumber" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"CheckPrinted" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"CheckDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Paid" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Memorize" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentClassID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"VendorID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"SystemDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"DueToDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PurchaseDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Amount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"UnAppliedAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBankAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentStatus" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"Void" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
"dbType" => "varchar(255)",
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
"CreditAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"SelectedForPayment" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"SelectedForPaymentDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ApprovedForPayment" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedForPaymentDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Cleared" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Posted" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Reconciled" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Credit" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
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
"VendorInvoiceNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PaymentID" => "Payment ID",
"InvoiceNumber" => "Purchase Number",
"PaymentTypeID" => "Payment Type",
"CheckNumber" => "Check Number",
"VendorID" => "Vendor ID",
"PaymentDate" => "Payment Date",
"CurrencyID" => "Currency ID",
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
"Amount" => "Amount",
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
