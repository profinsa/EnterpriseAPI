<?php
/*
  Name of Page: PurchaseHeaderList model
   
  Method: Model for gridView controller It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Zaharov Nikita
   
  Use: this model used by views/PurchaseHeaderList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by grid controller
  used as model by views/gridView.php
   
  Calls:
  MySql Database
   
  Last Modified: 25/07/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class PurchaseHeaderList extends gridDataSource{
	public $tableName = "purchaseheader";
	public $gridConditions = "(NOT LOWER(IFNULL(PurchaseHeader.TransactionTypeID,N'')) IN ('rma','debit memo')) AND ((IFNULL(Received,0) = 0) OR (IFNULL(PurchaseHeader.Paid,0) = 0) OR UPPER(PurchaseNumber)='DEFAULT')";
	public $dashboardTitle ="Purchases";
	public $breadCrumbTitle ="Purchases";
	public $idField ="PurchaseNumber";
    //	public $modes = ["grid", "view", "edit];
	public $idFields = ["CompanyID","DivisionID","DepartmentID","PurchaseNumber"];
    public $id = "";
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
		],
		"Shipped" => [
			"dbType" => "tinyint(1)",
			"inputType" => "checkbox"
		],
		"ShipDate" => [
			"dbType" => "datetime",
			"format" => "{0:d}",
			"inputType" => "datetime"
		],
        "TrackingNumber" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
		"Received" => [
			"dbType" => "tinyint(1)",
			"inputType" => "checkbox"
		],
        "RecivingNumber" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
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
            "ShipDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
				"defaultValue" => "now"
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
				"defaultValue" => ""
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
            "loadFrom" => [
                "method" => "getVendorInfo",
                "key" => "VendorID",
            ],
            "VendorID" => [
                "dbType" => "varchar(50)",
                "defaultValue" => "",
                "defaultOverride" => "true",
                "required" => "true",
                "inputType" => "text"
            ],
            "AccountStatus" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorName" => [
                "title" => "Name",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorAddress1" => [
                "title" => "addr 1",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorAddress2" => [
                "title" => "addr 2",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorAddress3" => [
                "title" => "addr 3",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorCity" => [
                "title" => "City",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorState" => [
                "title" => "State",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorZip" => [
                "title" => "Zip",
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorCountry" => [
                "title" => "Country",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorPhone" => [
                "title" => "Phone",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorFax" => [
                "title" => "Fax",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorEmail" => [
                "title" => "Email",
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorWebPage" => [
                "title" => "Web",
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Attention" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
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
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
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
            "RecivingNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "cloneFrom" => "PurchaseNumber"
            ],
            "PurchaseDate" => [
                "dbType" => "timestamp",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "VendorID" => [
                "dbType" => "varchar(50)",
                "inputType" => "dialogChooser",
                "dataProvider" => "getVendors",
                "required" => "true",
                "defaultOverride" => true,
                "defaultValue" => ""
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "text"
            ],
			"TransactionTypeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getARTransactionTypes",
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
				"defaultValue" => "now",
                "defaultValueExpression" => "return date('m/d/y', strtotime('+1 year'));"
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
			],
			"HeaderMemo1" => [
				"dbType" => "varchar(50)",
				"inputType" => "textarea",
				"defaultValue" => ""
			]
        ]
    ];

    public $headTableOne = [
        "Purchase Number" => "PurchaseNumber",
        "Purchase Date" => "PurchaseDate",
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
        "viewPath" => "AccountsPayable/PurchaseProcessing/ViewPurchasesDetail",
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
		"PurchaseNumber" => "Purchase Number",
		"TransactionTypeID" => "Transaction Type",
		"PurchaseDate" => "Purchase Date",
		"VendorID" => "Vendor ID",
		"CurrencyID" => "CurrencyID",
		"Total" => "Total",
		"Shipped" => "Shipped",
		"ShipDate" => "Ship Date",
		"Received" => "Received",
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
		"TrackingNumber" => "Tracking #",
		"ReceivedDate" => "Received Date",
		"RecivingNumber" => "Reciving #",
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
        "Attention" => "Attention",
        "ItemUnitPrice" => "Price",
        "ReceivingNumber" => "Receiving #",
        "TrackingNumber" => "Tracking #",
        "Received" => "Received",
        "ReceivedDate" => "Received Date",
        "ReceivedQty" => "Received Qty"
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
        if(!$id)
            $id = "DEFAULT";
        $user = Session::get("user");
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
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from vendorinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($id ? $result[0] : $result), true);
        
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
        $user = Session::get("user");
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

        
        $result = DB::select("SELECT " . implode(",", $fields) . " from purchasedetail " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function detailDelete(){
        $user = Session::get("user");
        $idFields = ["CompanyID","DivisionID","DepartmentID","PurchaseNumber", "PurchaseLineNumber"];
        $keyValues = explode("__", $_GET["item"]);
        $keyFields = "";
        $fcount = 0;
        foreach($idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        DB::delete("DELETE from purchasedetail " .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }

    public function getPrecision($currencyID) {
        $user = Session::get("user");

        $result = DB::select("SELECT CurrencyPrecision from currencytypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND CurrencyID='" . $currencyID . "'" , array());

        if ($result) {
            return $result[0]->CurrencyPrecision;
        } else {
            return 2;
        }
    }

    public function recalcPurchaseDetail($currencyPrecision, $purchaseDetail) {
        $DiscountPerc = $purchaseDetail->DiscountPerc;
        $Qty = $purchaseDetail->OrderQty;
        $Taxable = $purchaseDetail->Taxable;
        $TaxPercent = $purchaseDetail->TaxPercent;
        $ItemUnitPrice = $purchaseDetail->ItemUnitPrice;
        $SubTotal = round($Qty * $ItemUnitPrice, $currencyPrecision);

        $ItemDiscountAmount = round($Qty * $ItemUnitPrice * $DiscountPerc / 100, $currencyPrecision);
        $ItemTotal = round($Qty * $ItemUnitPrice * (100 - $DiscountPerc) / 100, $currencyPrecision);

        if ($Taxable == "1") {
            $ItemTaxAmount = round(($ItemTotal * $TaxPercent) / 100, $currencyPrecision);
            $TaxAmount = $ItemTaxAmount;
            $ItemTotalTaxable = $ItemTotal;
            $ItemTotal += $ItemTaxAmount;
        } else {
            $TaxAmount = 0;
            $ItemTotalTaxable = 0;
        }

        return [
            "ItemTotalTaxable" => $ItemTotalTaxable,
            "ItemDiscountAmount" => $ItemDiscountAmount,

            // for row updating PurchaseDetail
            "TaxAmount" => $TaxAmount,
            "Total" => $ItemTotal,
            "SubTotal" => $SubTotal
        ];
    }

    public function Recalc() {
        $user = Session::get("user");

        $purchaseNumber = $_POST["PurchaseNumber"];

        $result = DB::select("SELECT * from PurchaseHeader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseNumber='" . $purchaseNumber . "'", array());

        $purchaseHeader = $result[0];

        $SubTotal = 0;
        $Total = 0;
        $TotalTaxable = 0;
        $TaxAmount = 0;
        $HeaderTaxAmount = 0;
        $ItemTotalTaxable = 0;
        $ItemDiscountAmount = 0;
        $DiscountAmount = 0;

        $Precision = $this->getPrecision($purchaseHeader->CurrencyID);

        $purchaseDetails = DB::select("SELECT * from PurchaseDetail WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND PurchaseNumber='" . $purchaseNumber . "'", array());

        foreach($purchaseDetails as $purchaseDetail) {
            $detailResult = $this->recalcPurchaseDetail($Precision, $purchaseDetail);
            $SubTotal += $detailResult["SubTotal"];
            $Total += $detailResult["Total"];
            $TotalTaxable += $detailResult["ItemTotalTaxable"];
            $DiscountAmount += $detailResult["ItemDiscountAmount"];
            $TaxAmount += $detailResult["TaxAmount"];

            DB::update("UPDATE PurchaseDetail set TaxAmount='" . $detailResult["TaxAmount"] . "', Total='" . $detailResult["Total"] . "', SubTotal='" . $detailResult["SubTotal"] . "' WHERE PurchaseLineNumber='" . $purchaseDetail->PurchaseLineNumber ."'");
        }


        $Handling = $purchaseHeader->Handling;
        $HeaderTaxPercent = $purchaseHeader->TaxPercent;


        if($Handling > 0) {
            $HeaderTaxAmount = round($Handling * $HeaderTaxPercent / 100, $Precision);
        }

        $Freight = $purchaseHeader->Freight;
        $TaxFreight = $purchaseHeader->TaxFreight;

        if (($Freight > 0) && ($TaxFreight == "1")) {
            $HeaderTaxAmount = round($HeaderTaxAmount + $Freight * $HeaderTaxPercent / 100, $Precision);
        }

        $Total += ($Handling + $Freight + $HeaderTaxAmount);

        DB::update("UPDATE PurchaseHeader set SubTotal='" . $SubTotal . "', DiscountAmount='" . $DiscountAmount . "', TaxableSubTotal='" . $TotalTaxable . "', BalanceDue='" . round($Total - $purchaseHeader->AmountPaid, $Precision) ."', TaxAmount='" .($TaxAmount + $HeaderTaxAmount) . "', Total='" . $Total . "' WHERE PurchaseNumber='" . $purchaseNumber ."'");

        echo "ok";
    }

    public function Post(){
        $user = Session::get("user");

         DB::statement("CALL Purchase_Post2('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["PurchaseNumber"] . "',@PostingResult,@SWP_RET_VALUE)");

         $result = DB::select('select @PostingResult as PostingResult, @SWP_RET_VALUE as SWP_RET_VALUE');
         if($result[0]->SWP_RET_VALUE == -1) {
             http_response_code(400);
             echo $result[0]->PostingResult;
         } else 
            echo "ok";
    }

    public function UnPost(){
        $user = Session::get("user");

         DB::statement("CALL Purchase_Cancel('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["PurchaseNumber"] . "',@SWP_RET_VALUE)");

         $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
         if($result[0]->SWP_RET_VALUE == -1) {
             http_response_code(400);
             echo $result[0]->SWP_RET_VALUE;
         } else
             echo "ok";
    }

    public function Memorize(){
        $user = Session::get("user");
        $keyValues = explode("__", $_POST["id"]);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        DB::update("UPDATE " . $this->tableName . " set Memorize='" . ($_POST["Memorize"] == '1' ? '0' : '1') . "' WHERE ". $keyFields);
        echo "ok";
    }
    
    public function getPage($id){
        $user = Session::get("user");
        if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "last24"){
            $this->gridConditions .= "and PurchaseDate >= now() - INTERVAL 1 DAY";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "receivedtoday"){
            $this->gridConditions .= "and Received=0 and PurchaseDate >= now() - INTERVAL 1 DAY";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("ShipDate", $_GET)){
            $ShipDate = $_GET["ShipDate"];
            //            $ShipDate = date("Y-m-d H:i:s", strtotime($_GET["ShipDate"]));
            $this->gridConditions = "(NOT LOWER(IFNULL(PurchaseHeader.TransactionTypeID,N'')) IN ('rma','debit memo')) AND date(ShipDate)='$ShipDate'";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("ItemID", $_GET)){
            $ItemID = $_GET["ItemID"];
            $result = DB::select("select DISTINCT purchaseheader.PurchaseNumber, purchaseheader.CompanyID, purchaseheader.DivisionID, purchaseheader.DepartmentID, purchaseheader.PurchaseNumber, purchaseheader.TransactionTypeID, purchaseheader.PurchaseDate, purchaseheader.VendorID, purchaseheader.CurrencyID, purchaseheader.Total, purchaseheader.Shipped, purchaseheader.ShipDate, purchaseheader.TrackingNumber, purchaseheader.Received, purchaseheader.RecivingNumber from purchasedetail inner join purchaseheader on purchasedetail.PurchaseNumber=purchaseheader.PurchaseNumber AND purchasedetail.CompanyID=purchaseheader.CompanyID AND purchasedetail.DivisionID=purchaseheader.DivisionID AND purchasedetail.DepartmentID=purchaseheader.DepartmentID where purchaseheader.CompanyID=? AND purchaseheader.DivisionID=? AND purchaseheader.DepartmentID=? AND purchasedetail.ItemID=? AND purchaseheader.Received=0 AND purchaseheader.Posted=1", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $ItemID]);

            $result = json_decode(json_encode($result), true);
        //            $result = parent::getPage($id);
            return $result;
        }else{
            $result = parent::getPage($id);
            return $result;
        }
    }
}

class gridData extends PurchaseHeaderList {
}

class PurchaseHeaderSimpleList extends PurchaseHeaderList {
	public $dashboardTitle ="Quick Purchase";
	public $breadCrumbTitle ="Quick Purchase";
	public $reportType = "purchaseorder";

    // simple form section
    public $simpleInterface = [
        "showShipping" => false,
        "whom" => "Vendor",
        "customerTitle" => "Name / Address",
        "aboutOrder" => [
            "Purchase Number" => "PurchaseNumber",
            "Purchase Date" => "PurchaseDate",
            "Cancel Date" => "PurchaseCancelDate",
            "Type" => "TransactionTypeID"
        ],
        "customerFields" => [
            "VendorName" => "Name",
            "VendorAddress1" => "Address 1",
            "VendorAddress2" => "Address 2",
            "VendorAddress3" => "Address 3",
            "VendorCity" => "City",
            "VendorCountry" => "Country",
            "VendorState" => "State",
            "VendorZip" => "Zip"
        ],
        "shippingFields" => [
            "VendorName" => "ShippingName",
            "VendorAddress1" => "ShippingAddress1",
            "VendorAddress2" => "ShippingAddress2",
            "VendorAddress3" => "ShippingAddress3",
            "VendorCity" => "ShippingCity",
            "VendorCountry" => "ShippingCountry",
            "VendorState" => "ShippingState",
            "VendorZip" => "ShippingZip"
        ],
        "totalFields" => [
            "Sub-Total" => "Subtotal",
            "Tax" => "TaxAmount",
            "Total" => "Total"
        ],
        "aboutPurchase" => [
            "Vendor Invoice" => "VendorInvoiceNumber",
            "OrderedBy" => "OrderedBy",
            "Ship Date" => "ShipDate",
            "Ship Via" => "ShipMethodID",
            "Terms" => "TermsID"
        ]
    ];
}

class PurchaseHeaderClosedList extends PurchaseHeaderList{
	public $gridConditions = "(LOWER(IFNULL(PurchaseHeader.TransactionTypeID,N'')) NOT IN('rma','debit memo')) AND  IFNULL(Received,0) = 1 AND UPPER(PurchaseNumber <> 'DEFAULT')";
	public $dashboardTitle ="Closed Purchases";
	public $breadCrumbTitle ="Closed Purchases";
    public $modes = ["grid", "view", "edit"]; // list of enabled modes
    public $features = ["selecting"]; //list enabled features

    public function CopyToHistory(){
        $user = Session::get("user");

        $numbers = explode(",", $_POST["PurchaseNumbers"]);
        $success = true;
        foreach($numbers as $number){
            DB::statement("CALL Purchase_CopyToHistory2('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $number . "',@PostingResult,@SWP_RET_VALUE)");

            $result = DB::select('select @PostingResult as PostingResult, @SWP_RET_VALUE as SWP_RET_VALUE');
            if($result[0]->SWP_RET_VALUE == -1)
                $success = false;
        }

        if($success)
            echo "ok";
        else {
            http_response_code(400);
            echo $result[0]->SWP_RET_VALUE;
        }
    }

    public function CopyAllToHistory(){
        $user = Session::get("user");

        DB::statement("CALL Purchase_CopyAllToHistory('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "', @SWP_RET_VALUE)");

        $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
        if($result[0]->SWP_RET_VALUE > -1)
            echo $result[0]->SWP_RET_VALUE;
        else {
            http_response_code(400);
            echo $result[0]->SWP_RET_VALUE;
        }
    }
}

class PurchaseHeaderApproveList extends PurchaseHeaderList{
	public $gridConditions = "(IFNULL(PurchaseHeader.Posted,0)=1 AND IFNULL(Approved,0)=0 AND PurchaseNumber <> 'DEFAULT') AND (NOT LOWER(IFNULL(PurchaseHeader.TransactionTypeID,N'')) IN ('rma','debit memo'))";
	public $dashboardTitle ="Approve Purchases";
	public $breadCrumbTitle ="Approve Purchases";
    public $modes = ["grid"]; // list of enabled modes
    public $features = ["selecting"]; //list enabled features

    public function Purchase_Approve(){
        $user = Session::get("user");

        $purchaseIDs = explode(",", $_POST["PurchaseNumbers"]);
        $success = true;
        foreach($purchaseIDs as $purchaseID){
            DB::statement("CALL Purchase_Approve('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $purchaseID . "','" . $user["EmployeeID"] . "',@SWP_RET_VALUE)");

            $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
            if($result[0]->SWP_RET_VALUE == -1)
                $success = false;
        }

        if($success)
            echo "ok";
        else {
            http_response_code(400);
            echo $result[0]->SWP_RET_VALUE;
        }
    }
    
    public function Purchase_ApproveAll(){
        $user = Session::get("user");

        DB::statement("CALL Purchase_ApproveAll('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $user["EmployeeID"] . "',@SWP_RET_VALUE)");

        $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');

        if($result[0]->SWP_RET_VALUE > -1)
            echo $result[0]->SWP_RET_VALUE;
        else {
            http_response_code(400);
            echo $result[0]->SWP_RET_VALUE;
        }
    }
}

class PurchaseHeaderReceiveList extends PurchaseHeaderList{
	public $gridConditions = "(NOT LOWER(IFNULL(PurchaseHeader.TransactionTypeID,N'')) IN ('rma','debit memo')) AND (PurchaseHeader.Posted = 1 AND Approved = 1 AND IFNULL(Received,0) = 0 AND PurchaseNumber <> 'DEFAULT')";
	public $dashboardTitle ="Receive Purchases";
	public $breadCrumbTitle ="Receive Purchases";
    public $modes = ["grid", "edit", "edit"]; // list of enabled modes

	public $editCategories = [
		"Main" => [
            "PurchaseNumber" => [
                "dbType" => "varchar(36)",
                "disabledEdit" => true,
                "inputType" => "text"
            ],
            "Received" => [
                "dbType" => "tinyint(1)",
                "disabledEdit" => true,
                "inputType" => "checkbox"
            ],
            "ReceivedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime"
            ],
            "TrackingNumber" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RecivingNumber" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    //    public $detailPagesAsSubgrid = true;
    /*public $detailTable = [
        "viewPath" => "AccountsPayable/PurchaseProcessing/ViewPurchasesDetail",
        "newKeyField" => "PurchaseNumber",
        "keyFields" => ["PurchaseNumber", "PurchaseLineNumber"],
        ];*/
    public $detailPages = [
        "Main" => [
            //            "hideFields" => "true",
            "disableNew" => "true",
            "deleteDisabled" => "true",
            //"editDisabled" => "true",
            "viewPath" => "AccountsPayable/PurchaseProcessing/ViewPurchasesDetail",
            "newKeyField" => "PurchaseNumber",
            "keyFields" => ["PurchaseNumber", "PurchaseLineNumber"],
            "detailIdFields" => ["CompanyID","DivisionID","DepartmentID","PurchaseNumber", "PurchaseLineNumber"],
            "gridFields" => [
                "ItemID" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text",
                    "disabledEdit" => true
                ],
                "Description" => [
                    "dbType" => "varchar(80)",
                    "inputType" => "text",
                    "disabledEdit" => true
                ],
                "OrderQty" => [
                    "dbType" => "float",
                    "inputType" => "text",
                    "disabledEdit" => true
                ],
                "ReceivedQty" => [
                    "dbType" => "float",
                    "editable" => true,
                    "inputType" => "text"
                ],
                "ReceivedDate" => [
                    "dbType" => "datetime",
                    "editable" => true,
                    "inputType" => "datetime"
                ],
                "RecivingNumber" => [
                    "dbType" => "varchar(50)",
                    "editable" => true,
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "TrackingNumber" => [
                    "dbType" => "varchar(50)",
                    "editable" => true,
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "ItemUnitPrice" => [
                    "dbType" => "decimal(19,4)",
                    "format" => "{0:n}",
                    "inputType" => "text",
                    "disabledEdit" => true
                ],
                "Total" => [
                    "dbType" => "decimal(19,4)",
                    "format" => "{0:n}",
                    "inputType" => "text",
                    "disabledEdit" => true
                ]
            ]
        ]
    ];

    public function getMain($id){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->detailPages["Main"]["gridFields"] as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailPages["Main"]["detailIdFields"] as $key){
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

        
        $result = DB::select("SELECT " . implode(",", $fields) . " from purchasedetail " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
    
    public function Purchase_Split() {
        $user = Session::get("user");
        require "./models/EnterpriseASPAP/Purchases/PurchaseDetail.php";
        $purchaseDetail = new PurchaseDetail();

        $postData = file_get_contents("php://input");
        
        // `application/x-www-form-urlencoded`  `multipart/form-data`
        $data = parse_str($postData);
        // or
        // `application/json`
        $data = json_decode($postData, true);
        $this->updateItem("{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$data["header"]["PurchaseNumber"]}", "Main", $data["header"]);
        foreach($data["detail"] as $detail){
            $purchaseDetail->updateItem("{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$detail["PurchaseNumber"]}__{$detail["PurchaseLineNumber"]}", "Main", $detail);
        }

        DB::statement("CALL Purchase_Split('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $data["header"]["PurchaseNumber"] . "',@Success,@SWP_RET_VALUE)");

        $result = DB::select('select @Success as Success, @SWP_RET_VALUE as SWP_RET_VALUE');

        if($result[0]->SWP_RET_VALUE == -1) {
            http_response_code(400);
            echo $result[0]->Success;
        } else
            echo "ok";
    }

    public function Receiving_Post() {
        $user = Session::get("user");

        DB::statement("CALL Receiving_Post2('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["PurchaseNumber"] . "',@Success,@SWP_RET_VALUE)");

        $result = DB::select('select @Success as Success, @SWP_RET_VALUE as SWP_RET_VALUE');

        if($result[0]->SWP_RET_VALUE == -1) {
            http_response_code(400);
            echo $result[0]->Success;
        } else 
            echo "ok";
    }
}

class PurchaseHeaderReceivedList extends PurchaseHeaderList{
	public $gridConditions = "(NOT LOWER(IFNULL(PurchaseHeader.TransactionTypeID,N'')) IN ('rma','debit memo')) AND (IFNULL(PurchaseHeader.Received,0)=1) AND (IFNULL(PurchaseHeader.Paid,0)=0)";
	public $dashboardTitle ="Received Purchases";
	public $breadCrumbTitle ="Received Purchases";
    public $modes = ["grid", "view"]; // list of enabled modes
}

class PurchaseHeaderMemorizedList extends PurchaseHeaderList{
	public $gridConditions = "(NOT LOWER(IFNULL(PurchaseHeader.TransactionTypeID,N'')) IN ('rma','debit memo')) AND (IFNULL(PurchaseHeader.Memorize,0) = 1)";
	public $dashboardTitle ="Memorized Purchases";
	public $breadCrumbTitle ="Memorized Purchases";
    public $modes = ["grid", "view"]; // list of enabled modes
    public $features = ["selecting"];

    public function Purchase_CreateFromMemorized(){
        $user = Session::get("user");

        $numbers = explode(",", $_POST["PurchaseNumbers"]);
        $success = true;
        $messages = [];
        foreach($numbers as $number){
            DB::statement("CALL Purchase_CreateFromMemorized('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $number . "', @message, @SWP_RET_VALUE)", array());

            $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE, @message as message', array());
            $messages[] = $result[0]->message;
            ///echo $result[0]->message;
            if($result[0]->SWP_RET_VALUE == -1)
                $success = false;
            //usleep(300000);
        }

        if($success)
            echo implode("\n", $messages);
        else {
            http_response_code(400);
            echo $result[0]->SWP_RET_VALUE;
        }
    }
}
?>

