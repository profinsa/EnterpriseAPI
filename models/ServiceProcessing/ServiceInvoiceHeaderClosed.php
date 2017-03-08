<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "invoiceheader";
protected $gridFields =["InvoiceNumber","TransactionTypeID","InvoiceDate","CustomerID","CurrencyID","Total","ShipDate","OrderNumber"];
public $dashboardTitle ="Closed Service Invoices";
public $breadCrumbTitle ="Closed Service Invoices";
public $idField ="InvoiceNumber";
public $editCategories = [
"Main" => [

"InvoiceNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"OrderNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransOpen" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceDueDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceShipDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceCancelDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"SystemDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"Memorize" => [
"inputType" => "text",
"defaultValue" => ""
],
"PurchaseOrderNumber" => [
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
"CustomerID" => [
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
"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommissionPaid" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommissionSelectToPay" => [
"inputType" => "text",
"defaultValue" => ""
],
"Commission" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommissionableSales" => [
"inputType" => "text",
"defaultValue" => ""
],
"ComissionalbleCost" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerDropShipment" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipMethodID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForID" => [
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
"ScheduledStartDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ScheduledEndDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ServiceStartDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ServiceEndDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"PerformedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLSalesAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentMethodID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AmountPaid" => [
"inputType" => "text",
"defaultValue" => ""
],
"UndistributedAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"BalanceDue" => [
"inputType" => "text",
"defaultValue" => ""
],
"CheckNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"CheckDate" => [
"inputType" => "text",
"defaultValue" => ""
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
"inputType" => "text",
"defaultValue" => ""
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
"Picked" => [
"inputType" => "text",
"defaultValue" => ""
],
"PickedDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"Printed" => [
"inputType" => "text",
"defaultValue" => ""
],
"PrintedDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"Shipped" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"TrackingNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"Billed" => [
"inputType" => "text",
"defaultValue" => ""
],
"BilledDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"Backordered" => [
"inputType" => "text",
"defaultValue" => ""
],
"Posted" => [
"inputType" => "text",
"defaultValue" => ""
],
"PostedDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"AllowanceDiscountPerc" => [
"inputType" => "text",
"defaultValue" => ""
],
"CashTendered" => [
"inputType" => "text",
"defaultValue" => ""
],
"MasterBillOfLading" => [
"inputType" => "text",
"defaultValue" => ""
],
"MasterBillOfLadingDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"TrailerNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"TrailerPrefix" => [
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
"IncomeCreditMemo" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"InvoiceNumber" => "Invoice Number",
"TransactionTypeID" => "Type",
"InvoiceDate" => "Invoice Date",
"CustomerID" => "Customer ID",
"CurrencyID" => "Currency ID",
"Total" => "Total",
"ShipDate" => "Perform Date",
"OrderNumber" => "Order Number",
"TransOpen" => "TransOpen",
"InvoiceDueDate" => "InvoiceDueDate",
"InvoiceShipDate" => "InvoiceShipDate",
"InvoiceCancelDate" => "InvoiceCancelDate",
"SystemDate" => "SystemDate",
"Memorize" => "Memorize",
"PurchaseOrderNumber" => "PurchaseOrderNumber",
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
"EmployeeID" => "EmployeeID",
"CommissionPaid" => "CommissionPaid",
"CommissionSelectToPay" => "CommissionSelectToPay",
"Commission" => "Commission",
"CommissionableSales" => "CommissionableSales",
"ComissionalbleCost" => "ComissionalbleCost",
"CustomerDropShipment" => "CustomerDropShipment",
"ShipMethodID" => "ShipMethodID",
"WarehouseID" => "WarehouseID",
"ShipToID" => "ShipToID",
"ShipForID" => "ShipForID",
"ShippingName" => "ShippingName",
"ShippingAddress1" => "ShippingAddress1",
"ShippingAddress2" => "ShippingAddress2",
"ShippingAddress3" => "ShippingAddress3",
"ShippingCity" => "ShippingCity",
"ShippingState" => "ShippingState",
"ShippingZip" => "ShippingZip",
"ShippingCountry" => "ShippingCountry",
"ScheduledStartDate" => "ScheduledStartDate",
"ScheduledEndDate" => "ScheduledEndDate",
"ServiceStartDate" => "ServiceStartDate",
"ServiceEndDate" => "ServiceEndDate",
"PerformedBy" => "PerformedBy",
"GLSalesAccount" => "GLSalesAccount",
"PaymentMethodID" => "PaymentMethodID",
"AmountPaid" => "AmountPaid",
"UndistributedAmount" => "UndistributedAmount",
"BalanceDue" => "BalanceDue",
"CheckNumber" => "CheckNumber",
"CheckDate" => "CheckDate",
"CreditCardTypeID" => "CreditCardTypeID",
"CreditCardName" => "CreditCardName",
"CreditCardNumber" => "CreditCardNumber",
"CreditCardExpDate" => "CreditCardExpDate",
"CreditCardCSVNumber" => "CreditCardCSVNumber",
"CreditCardBillToZip" => "CreditCardBillToZip",
"CreditCardValidationCode" => "CreditCardValidationCode",
"CreditCardApprovalNumber" => "CreditCardApprovalNumber",
"Picked" => "Picked",
"PickedDate" => "PickedDate",
"Printed" => "Printed",
"PrintedDate" => "PrintedDate",
"Shipped" => "Shipped",
"TrackingNumber" => "TrackingNumber",
"Billed" => "Billed",
"BilledDate" => "BilledDate",
"Backordered" => "Backordered",
"Posted" => "Posted",
"PostedDate" => "PostedDate",
"AllowanceDiscountPerc" => "AllowanceDiscountPerc",
"CashTendered" => "CashTendered",
"MasterBillOfLading" => "MasterBillOfLading",
"MasterBillOfLadingDate" => "MasterBillOfLadingDate",
"TrailerNumber" => "TrailerNumber",
"TrailerPrefix" => "TrailerPrefix",
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
"Signature" => "Signature",
"SignaturePassword" => "SignaturePassword",
"SupervisorSignature" => "SupervisorSignature",
"SupervisorPassword" => "SupervisorPassword",
"ManagerSignature" => "ManagerSignature",
"ManagerPassword" => "ManagerPassword",
"IncomeCreditMemo" => "IncomeCreditMemo"];
}?>
