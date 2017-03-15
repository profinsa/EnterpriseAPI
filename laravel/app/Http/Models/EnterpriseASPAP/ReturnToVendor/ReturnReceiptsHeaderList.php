<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "receiptsheader";
protected $gridFields =["ReceiptID","ReceiptTypeID","CustomerID","TransactionDate","CurrencyID","Amount","Status","Deposited","Cleared","Reconciled","Posted"];
public $dashboardTitle ="ReceiptsHeader";
public $breadCrumbTitle ="ReceiptsHeader";
public $idField ="ReceiptID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ReceiptID"];
public $editCategories = [
"Main" => [

"ReceiptID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReceiptTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReceiptClassID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CheckNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"Memorize" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"SystemDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"DueToDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"OrderDate" => [
"inputType" => "datetime",
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
"Status" => [
"inputType" => "text",
"defaultValue" => ""
],
"NSF" => [
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"Cleared" => [
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
"Deposited" => [
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo1" => [
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo2" => [
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo3" => [
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo4" => [
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo5" => [
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo6" => [
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo7" => [
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo8" => [
"inputType" => "text",
"defaultValue" => ""
],
"HeaderMemo9" => [
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
]
]];
public $columnNames = [

"ReceiptID" => "Receipt ID",
"ReceiptTypeID" => "Receipt Type",
"CustomerID" => "Vendor ID",
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
