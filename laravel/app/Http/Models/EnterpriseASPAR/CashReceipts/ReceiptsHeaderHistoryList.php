<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "receiptsheaderhistory";
public $dashboardTitle ="Receipts History";
public $breadCrumbTitle ="Receipts History";
public $idField ="ReceiptID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ReceiptID"];
public $gridFields = [

"ReceiptID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReceiptTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CustomerID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TransactionDate" => [
    "dbType" => "timestamp",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"CurrencyID" => [
    "dbType" => "varchar(3)",
    "inputType" => "text"
],
"Amount" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"Status" => [
    "dbType" => "varchar(10)",
    "inputType" => "text"
],
"Deposited" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
],
"Cleared" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
],
"Reconciled" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
],
"Posted" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ReceiptID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReceiptTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReceiptClassID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CheckNumber" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"CustomerID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Memorize" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"TransactionDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
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
"OrderDate" => [
"dbType" => "datetime",
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
"Status" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"NSF" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Notes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"CreditAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Cleared" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Posted" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Reconciled" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Deposited" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"HeaderMemo1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo3" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo4" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo5" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo6" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo7" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo8" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo9" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
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
]
]];
public $columnNames = [

"ReceiptID" => "Receipt ID",
"ReceiptTypeID" => "Receipt Type",
"CustomerID" => "Customer ID",
"TransactionDate" => "Transaction Date",
"CurrencyID" => "Currency ID",
"Amount" => "Amount",
"Status" => "Status",
"Deposited" => "Deposited",
"Cleared" => "Cleared",
"Reconciled" => "Reconciled",
"Posted" => "Posted",
"ReceiptClassID" => "ReceiptClassID",
"CheckNumber" => "CheckNumber",
"Memorize" => "Memorize",
"SystemDate" => "SystemDate",
"DueToDate" => "DueToDate",
"OrderDate" => "OrderDate",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"UnAppliedAmount" => "UnAppliedAmount",
"GLBankAccount" => "GLBankAccount",
"NSF" => "NSF",
"Notes" => "Notes",
"CreditAmount" => "CreditAmount",
"HeaderMemo1" => "HeaderMemo1",
"HeaderMemo2" => "HeaderMemo2",
"HeaderMemo3" => "HeaderMemo3",
"HeaderMemo4" => "HeaderMemo4",
"HeaderMemo5" => "HeaderMemo5",
"HeaderMemo6" => "HeaderMemo6",
"HeaderMemo7" => "HeaderMemo7",
"HeaderMemo8" => "HeaderMemo8",
"HeaderMemo9" => "HeaderMemo9",
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
"ManagerPassword" => "ManagerPassword"];
}?>
