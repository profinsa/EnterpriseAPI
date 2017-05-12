<?php

/*
Name of Page: ServiceOrderHeaderInvoiceList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\ServiceProcessing\ServiceOrderHeaderInvoiceList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ServiceOrderHeaderInvoiceList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\ServiceProcessing\ServiceOrderHeaderInvoiceList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\ServiceProcessing\ServiceOrderHeaderInvoiceList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
	protected $tableName = "orderheader";
	protected $gridConditions = "(LOWER(IFNULL(OrderHeader.TransactionTypeID, N''))='service order') AND (LOWER(IFNULL(OrderHeader.OrderTypeID, N'')) <> 'hold') AND (OrderHeader.Shipped = 1) AND (IFNULL(OrderHeader.Invoiced,0) = 0)";
	public $dashboardTitle ="Invoice Service Orders";
	public $breadCrumbTitle ="Invoice Service Orders";
	public $idField ="OrderNumber";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","OrderNumber"];
	public $gridFields = [
		"OrderNumber" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"OrderTypeID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"OrderDate" => [
			"dbType" => "timestamp",
			"format" => "{0:d}",
			"inputType" => "datetime"
		],
		"CustomerID" => [
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
		"ShipDate" => [
			"dbType" => "datetime",
			"format" => "{0:d}",
			"inputType" => "datetime"
		]
	];

	public $editCategories = [
		"Main" => [
			"OrderNumber" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"TransactionTypeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"OrderTypeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"OrderDate" => [
				"dbType" => "timestamp",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"OrderDueDate" => [
				"dbType" => "timestamp",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"OrderShipDate" => [
				"dbType" => "timestamp",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"OrderCancelDate" => [
				"dbType" => "datetime",
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
			"PurchaseOrderNumber" => [
				"dbType" => "varchar(36)",
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
			"CustomerID" => [
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
			"EmployeeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"Commission" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CommissionableSales" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ComissionalbleCost" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			]
		],
		"Shipping" => [
			"CustomerDropShipment" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"ShipMethodID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"WarehouseID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ShipForID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ShipToID" => [
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
			"ScheduledStartDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"ScheduledEndDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"ServiceStartDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"ServiceEndDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"PerformedBy" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			]
		],
		"Payment" => [
			"GLSalesAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"PaymentMethodID" => [
				"dbType" => "varchar(36)",
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
			"Backordered" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"Picked" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"PickedDate" => [
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
			"Billed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"BilledDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"Invoiced" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"InvoiceNumber" => [
				"dbType" => "varchar(20)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"InvoiceDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
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
			"AllowanceDiscountPerc" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CashTendered" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			]
		],
		"Additional" => [
			"MasterBillOfLading" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"MasterBillOfLadingDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"TrailerNumber" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"TrailerPrefix" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			]
		],
		"Memos" => [
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
			]
		],
		"Approval" => [
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
		]
];
	public $columnNames = [
		"OrderNumber" => "Order Number",
		"OrderTypeID" => "Type",
		"OrderDate" => "Order Date",
		"CustomerID" => "Customer ID",
		"CurrencyID" => "Currency ID",
		"Total" => "Total",
		"ShipDate" => "Perform Date",
		"TransactionTypeID" => "Transaction Type ID",
		"OrderDueDate" => "Order Due Date",
		"OrderShipDate" => "Order Ship Date",
		"OrderCancelDate" => "Order Cancel Date",
		"SystemDate" => "System Date",
		"Memorize" => "Memorize",
		"PurchaseOrderNumber" => "Purchase Order Number",
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
		"EmployeeID" => "Employee ID",
		"Commission" => "Commission",
		"CommissionableSales" => "Commissionable Sales",
		"ComissionalbleCost" => "Comissionalble Cost",
		"CustomerDropShipment" => "Customer Drop Shipment",
		"ShipMethodID" => "ShipMethod ID",
		"WarehouseID" => "Warehouse ID",
		"ShipForID" => "Ship For ID",
		"ShipToID" => "Ship To ID",
		"ShippingName" => "Shipping Name",
		"ShippingAddress1" => "Shipping Address 1",
		"ShippingAddress2" => "Shipping Address 2",
		"ShippingAddress3" => "Shipping Address 3",
		"ShippingCity" => "Shipping City",
		"ShippingState" => "Shipping State",
		"ShippingZip" => "Shipping Zip",
		"ShippingCountry" => "Shipping Country",
		"ScheduledStartDate" => "Scheduled Start Date",
		"ScheduledEndDate" => "Scheduled End Date",
		"ServiceStartDate" => "Service Start Date",
		"ServiceEndDate" => "Service End Date",
		"PerformedBy" => "Performed By",
		"GLSalesAccount" => "GL Sales Account",
		"PaymentMethodID" => "Payment Method ID",
		"AmountPaid" => "Amount Paid",
		"BalanceDue" => "Balance Due",
		"UndistributedAmount" => "Undistributed Amount",
		"CheckNumber" => "Check Number",
		"CheckDate" => "Check Date",
		"CreditCardTypeID" => "Credit Card Type ID",
		"CreditCardName" => "Credit Card Name",
		"CreditCardNumber" => "Credit Card Number",
		"CreditCardExpDate" => "Credit Card Exp Date",
		"CreditCardCSVNumber" => "Credit Card CSV Number",
		"CreditCardBillToZip" => "Credit Card Bill To Zip",
		"CreditCardValidationCode" => "Credit Card Validation Code",
		"CreditCardApprovalNumber" => "Credit Card Approval Number",
		"Backordered" => "Backordered",
		"Picked" => "Picked",
		"PickedDate" => "Picked Date",
		"Printed" => "Printed",
		"PrintedDate" => "Printed Date",
		"Shipped" => "Shipped",
		"TrackingNumber" => "Tracking Number",
		"Billed" => "Billed",
		"BilledDate" => "Billed Date",
		"Invoiced" => "Invoiced",
		"InvoiceNumber" => "Invoice Number",
		"InvoiceDate" => "Invoice Date",
		"Posted" => "Posted",
		"PostedDate" => "Posted Date",
		"AllowanceDiscountPerc" => "Allowance Discount Perc",
		"CashTendered" => "Cash Tendered",
		"MasterBillOfLading" => "Master Bill Of Lading",
		"MasterBillOfLadingDate" => "Master Bill Of Lading Date",
		"TrailerNumber" => "Trailer Number",
		"TrailerPrefix" => "Trailer Prefix",
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
		"Signature" => "Signature",
		"SignaturePassword" => "Signature Password",
		"SupervisorSignature" => "Supervisor Signature",
		"SupervisorPassword" => "Supervisor Password",
		"ManagerSignature" => "Manager Signature",
		"ManagerPassword" => "Manager Password"
	];
}
?>
