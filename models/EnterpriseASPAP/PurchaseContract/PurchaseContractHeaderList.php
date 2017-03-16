<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "purchasecontractheader";
public $dashboardTitle ="PurchaseContractHeader";
public $breadCrumbTitle ="PurchaseContractHeader";
public $idField ="PurchaseContractNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PurchaseContractNumber"];
public $gridFields = [

"PurchaseContractDate" => [
    "dbType" => "timestamp",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"TransactionTypeID" => [
    "dbType" => "varchar(36)",
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
"ShipDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"PurchaseContractNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TransactionTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseContractDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PurchaseContractDueDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PurchaseContractStartDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PurchaseContractEndDate" => [
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
"inputType" => "text",
"defaultValue" => ""
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
"inputType" => "text",
"defaultValue" => ""
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
"inputType" => "text",
"defaultValue" => ""
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
"inputType" => "text",
"defaultValue" => ""
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
"Printed" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"PrintedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Shipped" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
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
"inputType" => "text",
"defaultValue" => ""
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
"inputType" => "text",
"defaultValue" => ""
],
"PostedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CommissionPaid" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"CommissionSelectToPay" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
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
"PurchaseContractOpen" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PurchaseContractDate" => "Contract Date",
"TransactionTypeID" => "Transaction Type ID",
"CurrencyID" => "Currency ID",
"Total" => "Total",
"ShipDate" => "Ship Date",
"PurchaseContractNumber" => "PurchaseContractNumber",
"PurchaseContractDueDate" => "PurchaseContractDueDate",
"PurchaseContractStartDate" => "PurchaseContractStartDate",
"PurchaseContractEndDate" => "PurchaseContractEndDate",
"PurchaseDateRequested" => "PurchaseDateRequested",
"SystemDate" => "SystemDate",
"Memorize" => "Memorize",
"OrderNumber" => "OrderNumber",
"VendorInvoiceNumber" => "VendorInvoiceNumber",
"OrderedBy" => "OrderedBy",
"TaxExemptID" => "TaxExemptID",
"TaxGroupID" => "TaxGroupID",
"VendorID" => "VendorID",
"TermsID" => "TermsID",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"Subtotal" => "Subtotal",
"DiscountPers" => "DiscountPers",
"DiscountAmount" => "DiscountAmount",
"TaxPercent" => "TaxPercent",
"TaxAmount" => "TaxAmount",
"TaxableSubTotal" => "TaxableSubTotal",
"Freight" => "Freight",
"TaxFreight" => "TaxFreight",
"Handling" => "Handling",
"Advertising" => "Advertising",
"ShipToWarehouse" => "ShipToWarehouse",
"WarehouseID" => "WarehouseID",
"ShipMethodID" => "ShipMethodID",
"ShippingName" => "ShippingName",
"ShippingAddress1" => "ShippingAddress1",
"ShippingAddress2" => "ShippingAddress2",
"ShippingAddress3" => "ShippingAddress3",
"ShippingCity" => "ShippingCity",
"ShippingState" => "ShippingState",
"ShippingZip" => "ShippingZip",
"ShippingCountry" => "ShippingCountry",
"Paid" => "Paid",
"PaymentID" => "PaymentID",
"PaymentMethodID" => "PaymentMethodID",
"PaymentDate" => "PaymentDate",
"GLPurchaseAccount" => "GLPurchaseAccount",
"AmountPaid" => "AmountPaid",
"BalanceDue" => "BalanceDue",
"UndistributedAmount" => "UndistributedAmount",
"CheckNumber" => "CheckNumber",
"CheckDate" => "CheckDate",
"PaidDate" => "PaidDate",
"CreditCardTypeID" => "CreditCardTypeID",
"CreditCardName" => "CreditCardName",
"CreditCardNumber" => "CreditCardNumber",
"CreditCardExpDate" => "CreditCardExpDate",
"CreditCardCSVNumber" => "CreditCardCSVNumber",
"CreditCardBillToZip" => "CreditCardBillToZip",
"CreditCardValidationCode" => "CreditCardValidationCode",
"CreditCardApprovalNumber" => "CreditCardApprovalNumber",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"Printed" => "Printed",
"PrintedDate" => "PrintedDate",
"Shipped" => "Shipped",
"TrackingNumber" => "TrackingNumber",
"Received" => "Received",
"ReceivedDate" => "ReceivedDate",
"RecivingNumber" => "RecivingNumber",
"Posted" => "Posted",
"PostedDate" => "PostedDate",
"CommissionPaid" => "CommissionPaid",
"CommissionSelectToPay" => "CommissionSelectToPay",
"OriginalPurchaseNumber" => "OriginalPurchaseNumber",
"OriginalPurchaseDate" => "OriginalPurchaseDate",
"HeaderMemo1" => "HeaderMemo1",
"HeaderMemo2" => "HeaderMemo2",
"HeaderMemo3" => "HeaderMemo3",
"HeaderMemo4" => "HeaderMemo4",
"HeaderMemo5" => "HeaderMemo5",
"HeaderMemo6" => "HeaderMemo6",
"HeaderMemo7" => "HeaderMemo7",
"HeaderMemo8" => "HeaderMemo8",
"HeaderMemo9" => "HeaderMemo9",
"EnteredBy" => "EnteredBy",
"Signature" => "Signature",
"SignaturePassword" => "SignaturePassword",
"SupervisorSignature" => "SupervisorSignature",
"SupervisorPassword" => "SupervisorPassword",
"ManagerSignature" => "ManagerSignature",
"ManagerPassword" => "ManagerPassword",
"PurchaseContractOpen" => "PurchaseContractOpen"];
}?>
