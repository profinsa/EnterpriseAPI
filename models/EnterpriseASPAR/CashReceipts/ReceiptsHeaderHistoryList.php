<?php

/*
Name of Page: ReceiptsHeaderHistoryList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\CashReceipts\ReceiptsHeaderHistoryList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ReceiptsHeaderHistoryList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\CashReceipts\ReceiptsHeaderHistoryList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\CashReceipts\ReceiptsHeaderHistoryList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
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
"ReceiptClassID" => "Receipt Class ID",
"CheckNumber" => "Check Number",
"Memorize" => "Memorize",
"SystemDate" => "System Date",
"DueToDate" => "Due To Date",
"OrderDate" => "Order Date",
"CurrencyExchangeRate" => "Currency Exchange Rate",
"UnAppliedAmount" => "UnApplied Amount",
"GLBankAccount" => "GL Bank Account",
"NSF" => "NSF",
"Notes" => "Notes",
"CreditAmount" => "Credit Amount",
"HeaderMemo1" => "Header Memo 1",
"HeaderMemo2" => "Header Memo 2",
"HeaderMemo3" => "Header Memo 3",
"HeaderMemo4" => "Header Memo 4",
"HeaderMemo5" => "Header Memo 5",
"HeaderMemo6" => "Header Memo 6",
"HeaderMemo7" => "Header Memo 7",
"HeaderMemo8" => "Header Memo 8",
"HeaderMemo9" => "Header Memo 9",
"Approved" => "Approved",
"ApprovedBy" => "Approved By",
"ApprovedDate" => "Approved Date",
"EnteredBy" => "Entered By",
"BatchControlNumber" => "Batch Control Number",
"BatchControlTotal" => "Batch Control Total",
"Signature" => "Signature",
"SignaturePassword" => "Signature Password",
"SupervisorSignature" => "Supervisor Signature",
"SupervisorPassword" => "Supervisor Password",
"ManagerSignature" => "Manager Signature",
"ManagerPassword" => "Manager Password"];
}?>
