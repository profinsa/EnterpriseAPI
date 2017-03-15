<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "purchaseheader";
protected $gridFields =["PurchaseNumber","TransactionTypeID","PurchaseDate","VendorID","CurrencyID","Total","Shipped","ShipDate","Received"];
public $dashboardTitle ="Approve Purchases";
public $breadCrumbTitle ="Approve Purchases";
public $idField ="PurchaseNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PurchaseNumber"];
public $editCategories = [
"Main" => [

"PurchaseNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"PurchaseDueDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"PurchaseShipDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"PurchaseCancelDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"PurchaseDateRequested" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"SystemDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"Memorize" => [
"inputType" => "text",
"defaultValue" => ""
],
"OrderNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorInvoiceNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"OrderedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxExemptID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxGroupID" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TermsID" => [
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
"Subtotal" => [
"inputType" => "text",
"defaultValue" => ""
],
"DiscountPers" => [
"inputType" => "text",
"defaultValue" => ""
],
"DiscountAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxPercent" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxableSubTotal" => [
"inputType" => "text",
"defaultValue" => ""
],
"Freight" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxFreight" => [
"inputType" => "text",
"defaultValue" => ""
],
"Handling" => [
"inputType" => "text",
"defaultValue" => ""
],
"Advertising" => [
"inputType" => "text",
"defaultValue" => ""
],
"Total" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToWarehouse" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipMethodID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShippingName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShippingAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShippingAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShippingAddress3" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShippingCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShippingState" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShippingZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShippingCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"Paid" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentMethodID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"GLPurchaseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"AmountPaid" => [
"inputType" => "text",
"defaultValue" => ""
],
"BalanceDue" => [
"inputType" => "text",
"defaultValue" => ""
],
"UndistributedAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"CheckNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"CheckDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"PaidDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"CreditCardTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardExpDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"CreditCardCSVNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardBillToZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardValidationCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditCardApprovalNumber" => [
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
"Printed" => [
"inputType" => "text",
"defaultValue" => ""
],
"PrintedDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"Shipped" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"TrackingNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"Received" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReceivedDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"RecivingNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"Posted" => [
"inputType" => "text",
"defaultValue" => ""
],
"PostedDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"CommissionPaid" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommissionSelectToPay" => [
"inputType" => "text",
"defaultValue" => ""
],
"OriginalPurchaseNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"OriginalPurchaseDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
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
"EnteredBy" => [
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
"PurchaseContractNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"IncomeTaxRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceNumber" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PurchaseNumber" => "Purchase Number",
"TransactionTypeID" => "Transaction Type",
"PurchaseDate" => "Purchase Date",
"VendorID" => "Vendor ID",
"CurrencyID" => "CurrencyID",
"Total" => "Total",
"Shipped" => "Shipped",
"ShipDate" => "Ship Date",
"Received" => "Received",
"PurchaseDueDate" => "PurchaseDueDate",
"PurchaseShipDate" => "PurchaseShipDate",
"PurchaseCancelDate" => "PurchaseCancelDate",
"PurchaseDateRequested" => "PurchaseDateRequested",
"SystemDate" => "SystemDate",
"Memorize" => "Memorize",
"OrderNumber" => "OrderNumber",
"VendorInvoiceNumber" => "VendorInvoiceNumber",
"OrderedBy" => "OrderedBy",
"TaxExemptID" => "TaxExemptID",
"TaxGroupID" => "TaxGroupID",
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
"TrackingNumber" => "TrackingNumber",
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
"PurchaseContractNumber" => "PurchaseContractNumber",
"IncomeTaxRate" => "IncomeTaxRate",
"InvoiceNumber" => "InvoiceNumber"];
}?>
