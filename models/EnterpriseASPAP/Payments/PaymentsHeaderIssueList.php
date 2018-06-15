<?php
/*
Name of Page: PaymentsHeaderIssueList model
 
Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAP\Payments\PaymentsHeaderIssueList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PaymentsHeaderIssueList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAP\Payments\PaymentsHeaderIssueList.php
used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAP\Payments\PaymentsHeaderIssueList.php
 
Calls:
MySql Database
 
Last Modified: 08/15/2017
Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "paymentsheader";
public $gridConditions = "(IFNULL(ApprovedForPayment,0) = 1 AND IFNULL(CheckPrinted,0) = 0 AND IFNULL(Posted,0) = 1 AND IFNULL(Paid,0) = 0)";
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
    "format" => "{0:d}",
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
"inputType" => "checkbox",
"defaultValue" => "0"
],
"CheckDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Paid" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"PaymentDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Memorize" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
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
"inputType" => "checkbox",
"defaultValue" => "0"
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
"inputType" => "checkbox",
"defaultValue" => "0"
],
"SelectedForPaymentDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ApprovedForPayment" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApprovedForPaymentDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Cleared" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"InvoiceNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
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
"Credit" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
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
"CheckPrinted" => "Check Printed",
"CheckDate" => "Check Date",
"Paid" => "Paid",
"Memorize" => "Memorize",
"PaymentClassID" => "Payment Class ID",
"SystemDate" => "System Date",
"DueToDate" => "Due To Date",
"PurchaseDate" => "Purchase Date",
"Amount" => "Amount",
"UnAppliedAmount" => "UnApplied Amount",
"GLBankAccount" => "GL Bank Account",
"PaymentStatus" => "Payment Status",
"Void" => "Void",
"Notes" => "Notes",
"CurrencyExchangeRate" => "Currency Exchange Rate",
"CreditAmount" => "Credit Amount",
"SelectedForPayment" => "Selected For Payment",
"SelectedForPaymentDate" => "Selected For Payment Date",
"ApprovedForPayment" => "Approved For Payment",
"ApprovedForPaymentDate" => "Approved For Payment Date",
"Credit" => "Credit",
"ApprovedBy" => "Approved By",
"EnteredBy" => "Entered By",
"BatchControlNumber" => "Batch Control Number",
"BatchControlTotal" => "Batch Control Total",
"Signature" => "Signature",
"SignaturePassword" => "Signature Password",
"SupervisorSignature" => "Supervisor Signature",
"SupervisorPassword" => "Supervisor Password",
"ManagerSignature" => "Manager Signature",
"ManagerPassword" => "Manager Password",
"VendorInvoiceNumber" => "Vendor Invoice Number"];
}?>
