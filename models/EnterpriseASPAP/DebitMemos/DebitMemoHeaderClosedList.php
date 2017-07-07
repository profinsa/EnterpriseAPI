<?php

/*
Name of Page: DebitMemoHeaderClosedList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\DebitMemos\DebitMemoHeaderClosedList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/DebitMemoHeaderClosedList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\DebitMemos\DebitMemoHeaderClosedList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\DebitMemos\DebitMemoHeaderClosedList.php
 
Calls:
MySql Database
 
Last Modified: 04/13/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
	protected $tableName = "purchaseheader";
    protected $gridConditions = "(ABS(IFNULL(PurchaseHeader.BalanceDue, 0)) < 0.005) AND (ABS(IFNULL(PurchaseHeader.Total, 0)) >= 0.005) AND (LOWER(IFNULL(PurchaseHeader.TransactionTypeID, N'')) = 'debit memo') AND (IFNULL(PurchaseHeader.Posted, 0) = 1)"; 
	public $dashboardTitle ="Closed Debit Memos";
	public $breadCrumbTitle ="Closed Debit Memos";
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
        ]
    ];

	public $editCategories = [
		"Main" => [
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
            /*			"CustomerDropShipment" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
                ],
			"AllowanceDiscountPerc" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
			],*/
			"PurchaseDueDate" => [
				"dbType" => "timestamp",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"TaxExemptID" => [
				"dbType" => "varchar(20)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CurrencyID" => [
				"dbType" => "varchar(3)",
				"inputType" => "dropdown",
                "dataProvider" => "getCurrencyTypes",
				"defaultValue" => "USD"
			],
			"CurrencyExchangeRate" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"DiscountAmount" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

			],
			"TaxableSubTotal" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

			],
			"Advertising" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

			],
            /*			"Commission" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

			],
			"CommissionableSales" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

			],
			"ComissionalbleCost" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

                ]*/
		],
        "Vendor" => [
            "VendorID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text"
            ]
        ],
		"Payment" => [
			"GLPurchaseAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"PaymentMethodID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getPaymentMethods",
				"defaultValue" => ""
			],
			"AmountPaid" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "addFields" => "CurrencyID",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
			],
			"BalanceDue" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
			],
			"UndistributedAmount" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
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
				"inputType" => "dropdown",
                "dataProvider" => "getCreditCardTypes",
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
		],
        "...fields" => [
            "OrderNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true"
            ],
            "VendorInvoiceNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true"
            ],
            "OrderedBy" => [
                "dbType" => "varchar(15)",
                "inputType" => "text",
                "disabledEdit" => "true"
            ],
            "PurchaseNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => "(new)",
                "dirtyAutoincrement" => "true"
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
			"TransactionTypeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getARTransactionTypes",
				"defaultValue" => ""
			],
			"PurchaseCancelDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"ShipMethodID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getShipMethods",
				"defaultValue" => ""
			],
			"WarehouseID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getWarehouses",
				"defaultValue" => ""
			],
            "OrderNumber" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => "",
                "disabledEdit" => "true"
			],
			"PurchaseDate" => [
				"dbType" => "timestamp",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
            "Total" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

			],
            /*			"EmployeeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
				"defaultValue" => ""
                ],*/
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
			"SystemDate" => [
				"dbType" => "timestamp",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"Memorize" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0",
                "disabledEdit" => "true"
			],
            "TaxGroupID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
            /*			"CustomerID" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
                ],*/
			"TermsID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getTerms",
				"defaultValue" => ""
			],
			"Subtotal" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
			],
            "Freight" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

			],
			"TaxFreight" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"Handling" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

			],
			"Advertising" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

			],
            "TaxPercent" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"TaxAmount" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

			],
            "DiscountPers" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
			],
            /*            "Backordered" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
                ],*/
            "Approved" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
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
            /*			"InvoiceDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
            /*			"Invoiced" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],*/
			"InvoiceNumber" => [
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
            /*			"AllowanceDiscountPerc" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
                ],
			"CashTendered" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
            ],*/
			"AmountPaid" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "addFields" => "CurrencyID",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
			],
            "BalanceDue" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
			]
        ]
    ];

    public $headTableOne = [
        "Debit Memo Number" => "PurchaseNumber",
        "Debit Memo Date" => "PurchaseDate",
        "Transaction Type" => "TransactionTypeID",
    ];

    public $headTableTwo = [
        "Cancel Date" => "PurchaseCancelDate",
        "Vendor ID" => "VendorID",
        "Warehouse" => "WarehouseID"
    ];

    public $headTableThree = [
        "Vendor Invoice" => "VendorInvoiceNumber",
        "Ordered By" => "OrderedBy",
        "Ship Date" => "PurchaseShipDate",
        "Ship Via" => "ShipMethodID",
        "Terms" => "TermsID"
    ];

    public $customerField = "VendorID";
    
    public $detailTable = [
        "viewPath" => "AccountsPayable/DebitMemos/ViewDebitMemoDetail",
        "newKeyField" => "PurchaseNumber",
        "keyFields" => ["PurchaseNumber", "PurchaseLineNumber"],
    ];

    public $footerTable = [
        "flagsHeader" => [
            "Memorized" => "Memorize"
        ],
        "flags" => [
            ["Posted", "Posted", "PostedDate", "Posted Date"],
            ["Printed", "Printed", "PrintedDate", "Printed Date"],
            ["Approved", "Approved", "ApprovedDate", "Approved Date"],
            ["Received", "Received", "ReceivedDate", "Received Date"],
            ["Shipped", "Shipped", "PurchaseShipDate", "Shipped Date"],
        ],
        "totalFields" => [
            "Subtotal" => "Subtotal",
            "Shipping" => "Freight",
            "Handling" => "Handling",
            "Tax" => "TaxAmount",
            "Total" => "Total",
            "Payments" => "AmountPaid",
            "Balance Due" => "BalanceDue"
        ]
    ];
    
	public $columnNames = [
        "PurchaseNumber" => "Debit Memo Number",
        "TransactionTypeID" => "Transaction Type",
        "PurchaseDate" => "Debit Memo Date",
        "VendorID" => "Vendor ID",
        "CurrencyID" => "Currency ID",
        "Total" => "Amount",
        "PurchaseDueDate" => "Purchase Due Date",
        "PurchaseShipDate" => "Purchase Ship Date",
        "PurchaseCancelDate" => "Purchase Cancel Date",
        "PurchaseDateRequested" => "Purchase Date Requested",
        "SystemDate" => "System Date",
        "Memorize" => "Memorize",
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
        "PaymentID" => "Payment ID",
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
        "Shipped" => "Shipped",
        "ShipDate" => "Ship Date",
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
        "HeaderMemo1" => "Memo 1",
        "HeaderMemo2" => "Memo 2",
        "HeaderMemo3" => "Memo 3",
        "HeaderMemo4" => "Memo 4",
        "HeaderMemo5" => "Memo 5",
        "HeaderMemo6" => "Memo 6",
        "HeaderMemo7" => "Memo 7",
        "HeaderMemo8" => "Memo 8",
        "HeaderMemo9" => "Memo 9",
        "EnteredBy" => "Entered By",
        "Signature" => "Signature",
        "SignaturePassword" => "Signature Password",
        "SupervisorSignature" => "Supervisor Signature",
        "SupervisorPassword" => "Supervisor Password",
        "ManagerSignature" => "Manager Signature",
        "ManagerPassword" => "Manager Password",
        "PurchaseContractNumber" => "Purchase Contract Number",
        "IncomeTaxRate" => "Income Tax Rate",
        "InvoiceNumber" => "Invoice Number",
        "OrderQty" => "Qty",
        "ItemID" => "Item ID",
        "Description" => "Description",
        "ItemUOM" => "UOM",
        "ItemUnitPrice" => "Price",
        "Total" => "Total",
        "GLPurchaseAccount" => "Purchase Account",
        "ProjectID" => "ProjectID",
        "VendorID" => "Vendor ID",
        "AccountStatus" => "Accounts Status",
        "VendorName" => "Name",
        "VendorAddress1" => "Addr 1",
        "VendorAddress2" => "Addr 2",
        "VendorAddress3" => "Addr 3",
        "VendorCity" => "City",
        "VendorState" => "State",
        "VendorZip" => "Zip",
        "VendorCountry" => "Country",
        "VendorPhone" => "Phone",
        "VendorFax" => "Fax",
        "VendorEmail" => "Email",
        "VendorWebPage" => "Web",
        "Attention" => "Attention"
	];

    public $vendorFields = [
        "VendorID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "AccountStatus" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorAddress1" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorAddress2" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorAddress3" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorCity" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorState" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorZip" => [
            "dbType" => "varchar(10)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorCountry" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorPhone" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorFax" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorEmail" => [
            "dbType" => "varchar(60)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorWebPage" => [
            "dbType" => "varchar(80)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "Attention" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $vendorIdFields = ["CompanyID","DivisionID","DepartmentID","VendorID"];
    //getting data for Vendor Page
    public function getVendorInfo($id){
        $user = $_SESSION["user"];
        $keyFields = "";
        $fields = [];
        foreach($this->vendorFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->vendorIdFields as $key){
            switch($key){
            case "CompanyID" :
                $keyFields .= "CompanyID='" . $user["CompanyID"] . "' AND ";
                break;
            case "DivisionID" :
                $keyFields .= "DivisionID='" . $user["DivisionID"] . "' AND ";
                break;
            case "DepartmentID" :
                $keyFields .= "DepartmentID='" . $user["DepartmentID"] . "' AND ";
                break;
            }
            if(!in_array($key, $fields))
                $fields[] = $key;                
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        if($id)
            $keyFields .= " AND VendorID='" . $id . "'";
        
        $result = $GLOBALS["DB"]::select("SELECT " . implode(",", $fields) . " from vendorinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($id ? $result[0] : $result), true);
        
        return $result;
    }

    public function getVendors(){
        $user = $_SESSION["user"];
        $keyFields = "";
        $fields = [];

        foreach($this->vendorIdFields as $key){
            switch($key){
            case "CompanyID" :
                $keyFields .= "CompanyID='" . $user["CompanyID"] . "' AND ";
                break;
            case "DivisionID" :
                $keyFields .= "DivisionID='" . $user["DivisionID"] . "' AND ";
                break;
            case "DepartmentID" :
                $keyFields .= "DepartmentID='" . $user["DepartmentID"] . "' AND ";
                break;
            }
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = $GLOBALS["DB"]::select("SELECT * from vendorinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public $detailIdFields = ["CompanyID","DivisionID","DepartmentID","PurchaseNumber", "PurchaseLineNumber"];
	public $embeddedgridFields = [
		"ItemID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"Description" => [
			"dbType" => "varchar(80)",
			"inputType" => "text"
		],
		"OrderQty" => [
			"dbType" => "float",
			"inputType" => "text"
		],
		"ItemUOM" => [
            "dbType" => "varchar(15)",
            "inputType" => "text"
		],
        "ItemUnitPrice" =>	[
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
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
		"GLPurchaseAccount" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"ProjectID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		]
	];
    
    //getting rows for grid
    public function getDetail($id){
        $user = $_SESSION["user"];
        $keyFields = "";
        $fields = [];
        foreach($this->embeddedgridFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailIdFields as $key){
            switch($key){
            case "CompanyID" :
                $keyFields .= "CompanyID='" . $user["CompanyID"] . "' AND ";
                break;
            case "DivisionID" :
                $keyFields .= "DivisionID='" . $user["DivisionID"] . "' AND ";
                break;
            case "DepartmentID" :
                $keyFields .= "DepartmentID='" . $user["DepartmentID"] . "' AND ";
                break;
            }
            if(!in_array($key, $fields))
                $fields[] = $key;                
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $keyFields .= " AND PurchaseNumber='" . $id . "'";

        
        $result = $GLOBALS["DB"]::select("SELECT " . implode(",", $fields) . " from purchasedetail " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function detailDelete(){
        $user = $_SESSION["user"];
        $idFields = ["CompanyID","DivisionID","DepartmentID","PurchaseNumber", "PurchaseLineNumber"];
        $keyValues = explode("__", $_GET["item"]);
        $keyFields = "";
        $fcount = 0;
        foreach($idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        $GLOBALS["DB"]::delete("DELETE from purchasedetail " .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }

    /*public $editCategories = [
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
            ]
		],
		"Payment" => [
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
		],
		"Memos" => [
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
            ],
            "PurchaseContractNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
        ];*/
}
?>
