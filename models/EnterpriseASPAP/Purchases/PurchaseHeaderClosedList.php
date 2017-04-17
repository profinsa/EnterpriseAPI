<?php

/*
Name of Page: PurchaseHeaderClosedList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Purchases\PurchaseHeaderClosedList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PurchaseHeaderClosedList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Purchases\PurchaseHeaderClosedList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Purchases\PurchaseHeaderClosedList.php
 
Calls:
MySql Database
 
Last Modified: 04/13/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "purchaseheader";
public $dashboardTitle ="Closed Purchases";
public $breadCrumbTitle ="Closed Purchases";
public $idField ="PurchaseNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PurchaseNumber"];
public $gridFields = [

"PurchaseNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TransactionTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PaymentID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"InvoiceNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PurchaseDate" => [
    "dbType" => "timestamp",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"VendorID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CurrencyID" => [
    "dbType" => "varchar(3)",
    "inputType" => "text"
],
"Total" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"Shipped" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
],
"ShipDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"Memorize" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PurchaseNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TransactionTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PurchaseDueDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PurchaseShipDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PurchaseCancelDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PurchaseDateRequested" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"SystemDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Memorize" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"OrderNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"VendorInvoiceNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"OrderedBy" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxExemptID" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxGroupID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"VendorID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TermsID" => [
"dbType" => "varchar(36)",
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
"Subtotal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"DiscountPers" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"DiscountAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxPercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"TaxAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxableSubTotal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Freight" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxFreight" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Handling" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Advertising" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Total" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipToWarehouse" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"WarehouseID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ShipMethodID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ShippingName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShippingAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShippingAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShippingAddress3" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShippingCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShippingState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ShippingZip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"ShippingCountry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Paid" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"PaymentID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentMethodID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"GLPurchaseAccount" => [
"dbType" => "varchar(25)",
"inputType" => "text",
"defaultValue" => ""
],
"AmountPaid" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"BalanceDue" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"UndistributedAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"CheckNumber" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"CheckDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PaidDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CreditCardTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardExpDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CreditCardCSVNumber" => [
"dbType" => "varchar(5)",
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardBillToZip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardValidationCode" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardApprovalNumber" => [
"dbType" => "varchar(20)",
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
"Printed" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"PrintedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Shipped" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ShipDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"TrackingNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Received" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ReceivedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"RecivingNumber" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"Posted" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"PostedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CommissionPaid" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"CommissionSelectToPay" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"OriginalPurchaseNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"OriginalPurchaseDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"HeaderMemo1" => [
"dbType" => "varchar(500)",
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
"EnteredBy" => [
"dbType" => "varchar(36)",
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
"PurchaseContractNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"IncomeTaxRate" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PurchaseNumber" => "Purchase Number",
"TransactionTypeID" => "Transaction Type",
"PaymentID" => "Payment ID",
"InvoiceNumber" => "Payment Number",
"PurchaseDate" => "Purchase Date",
"VendorID" => "Vendor ID",
"CurrencyID" => "CurrencyID",
"Total" => "Total",
"Shipped" => "Shipped",
"ShipDate" => "Ship Date",
"Memorize" => "Memorized",
"PurchaseDueDate" => "Purchase Due Date",
"PurchaseShipDate" => "Purchase Ship Date",
"PurchaseCancelDate" => "Purchase Cancel Date",
"PurchaseDateRequested" => "Purchase Date Requested",
"SystemDate" => "System Date",
"OrderNumber" => "Order Number",
"VendorInvoiceNumber" => "Vendor Invoice Number",
"OrderedBy" => "Ordered By",
"TaxExemptID" => "Tax Exempt ID",
"TaxGroupID" => "Tax Group ID",
"TermsID" => "Terms ID",
"CurrencyExchangeRate" => "Currency Exchange Rate",
"Subtotal" => "Subtotal",
"DiscountPers" => "Discount Pers",
"DiscountAmount" => "Discount Amount",
"TaxPercent" => "Tax Percent",
"TaxAmount" => "Tax Amount",
"TaxableSubTotal" => "Taxable Sub Total",
"Freight" => "Freight",
"TaxFreight" => "Tax Freight",
"Handling" => "Handling",
"Advertising" => "Advertising",
"ShipToWarehouse" => "Ship To Warehouse",
"WarehouseID" => "Warehouse ID",
"ShipMethodID" => "Ship Method ID",
"ShippingName" => "Shipping Name",
"ShippingAddress1" => "Shipping Address 1",
"ShippingAddress2" => "Shipping Address 2",
"ShippingAddress3" => "Shipping Address 3",
"ShippingCity" => "Shipping City",
"ShippingState" => "Shipping State",
"ShippingZip" => "Shipping Zip",
"ShippingCountry" => "Shipping Country",
"Paid" => "Paid",
"PaymentMethodID" => "Payment Method ID",
"PaymentDate" => "Payment Date",
"GLPurchaseAccount" => "GL Purchase Account",
"AmountPaid" => "Amount Paid",
"BalanceDue" => "Balance Due",
"UndistributedAmount" => "Undistributed Amount",
"CheckNumber" => "Check Number",
"CheckDate" => "Check Date",
"PaidDate" => "Paid Date",
"CreditCardTypeID" => "Credit Card Type ID",
"CreditCardName" => "Credit Card Name",
"CreditCardNumber" => "Credit Card Number",
"CreditCardExpDate" => "Credit Card Exp Date",
"CreditCardCSVNumber" => "Credit Card CSV Number",
"CreditCardBillToZip" => "Credit Card Bill To Zip",
"CreditCardValidationCode" => "Credit Card Validation Code",
"CreditCardApprovalNumber" => "Credit Card Approval Number",
"Approved" => "Approved",
"ApprovedBy" => "Approved By",
"ApprovedDate" => "Approved Date",
"Printed" => "Printed",
"PrintedDate" => "Printed Date",
"TrackingNumber" => "Tracking Number",
"Received" => "Received",
"ReceivedDate" => "Received Date",
"RecivingNumber" => "Reciving Number",
"Posted" => "Posted",
"PostedDate" => "Posted Date",
"CommissionPaid" => "Commission Paid",
"CommissionSelectToPay" => "Commission Select To Pay",
"OriginalPurchaseNumber" => "Original Purchase Number",
"OriginalPurchaseDate" => "Original Purchase Date",
"HeaderMemo1" => "Header Memo 1",
"HeaderMemo2" => "Header Memo 2",
"HeaderMemo3" => "Header Memo 3",
"HeaderMemo4" => "Header Memo 4",
"HeaderMemo5" => "Header Memo 5",
"HeaderMemo6" => "Header Memo 6",
"HeaderMemo7" => "Header Memo 7",
"HeaderMemo8" => "Header Memo 8",
"HeaderMemo9" => "Header Memo 9",
"EnteredBy" => "Entered By",
"Signature" => "Signature",
"SignaturePassword" => "Signature Password",
"SupervisorSignature" => "Supervisor Signature",
"SupervisorPassword" => "Supervisor Password",
"ManagerSignature" => "Manager Signature",
"ManagerPassword" => "Manager Password",
"PurchaseContractNumber" => "Purchase Contract Number",
"IncomeTaxRate" => "Income Tax Rate",
}?>
