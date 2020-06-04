<?php
/*
  Name of Page: QuoteHeaderList model

  Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\OrderProcessing\QuoteHeaderList.php It provides data from database and default values, column names and categories

  Date created: 02/16/2017 NikitaZaharov

  Use: this model used by views/QuoteHeaderList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\OrderProcessing\QuoteHeaderList.php
  used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\OrderProcessing\QuoteHeaderList.php

  Calls:
  MySql Database

  Last Modified: 27/09/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
require "./models/helpers/recalc.php";

class QuoteHeaderList extends gridDataSource{
	public $tableName = "orderheader";
	public $gridConditions = "LOWER(OrderTypeID) = LOWER('Quote')";
	public $dashboardTitle ="Quotes";
	public $breadCrumbTitle ="Quotes";
    public $docType = "quote";
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
		],
        "TrackingNumber" => [
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
			"CustomerDropShipment" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"AllowanceDiscountPerc" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"OrderDueDate" => [
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
			"Commission" => [
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

			]
		],
        "Customer" => [
            "loadFrom" => [
                "method" => "getCustomerInfo",
                "key" => "CustomerID",
            ],
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "defaultValue" => "",
                "defaultOverride" => "true",
                "required" => "true",
                "inputType" => "text"
            ],
            "AccountStatus" => [
                "title" => "Account Status",
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
			"ShippingName" => [
                "title" => "Customer Name",
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ShippingAddress1" => [
                "title" => "Customer Address 1",
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ShippingAddress2" => [
                "title" => "Customer Address 3",
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ShippingAddress3" => [
                "title" => "Customer Address 3",
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ShippingCity" => [
                "title" => "Customer City",
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ShippingState" => [
                "title" => "Customer State",
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ShippingZip" => [
                "title" => "Customer Zip",
				"dbType" => "varchar(10)",
				"inputType" => "text",
				"defaultValue" => "",
                "disabled" => "true"
			],
			"ShippingCountry" => [
                "title" => "Customer Country",
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => "",
                "disabled" => "true"
			],
            "CustomerPhone" => [
                "title" => "Customer Phone",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerFax" => [
                "title" => "Customer Fax",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerEmail" => [
                "title" => "Customer Email",
                "dbType" => "varchar(60)",
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
			"GLSalesAccount" => [
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
			]/*,
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
                ]*/
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
		],
        "...fields" => [
            "OrderNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => "(new)",
                "dirtyAutoincrement" => "true"
            ],
            "OrderDate" => [
                "dbType" => "timestamp",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "defaultValue" => "",
                "defaultOverride" => "true",
                "required" => "true",
                "inputType" => "dialogChooser",
                "dataProvider" => "getCustomers"
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "text"
            ],
			"TransactionTypeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getARTransactionTypes",
				"defaultValue" => "",
                "defaultOverride" => true,
				"defaultValue" => "Quote"
			],
			"OrderCancelDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now",
                "defaultValueExpression" => "return date('m/d/y', strtotime('+1 year'));"
			],
			"ShipForID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getShipForIDS",
                "dataProviderArgs" => ["CustomerID", "ShipToID"],
				"defaultValue" => ""
			],
			"ShipToID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getShipToIDS",
                "dataProviderArgs" => ["CustomerID"],
				"defaultValue" => ""
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
			"OrderTypeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getOrderTypes",
				"defaultValue" => "",
                "defaultOverride" => true,
				"defaultValue" => "Quote"
			],
			"OrderDate" => [
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
			"EmployeeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
				"defaultValue" => ""
			],
            "OrderShipDate" => [
				"dbType" => "timestamp",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"OrderCancelDate" => [
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
			"PurchaseOrderNumber" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],	
            "TaxGroupID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
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
				"defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
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
			]
        ]
    ];

    public $headTableOne = [
        "Order Number" => "OrderNumber",
        "Order Date" => "OrderDate",
        "Order Type" => "OrderTypeID",
        "Transaction Type" => "TransactionTypeID",
        "Cancel Date" => "OrderCancelDate"
    ];

    public $headTableTwo = [
        "Customer ID" => "CustomerID",
        "Ship To" => "ShipToID",
        "Ship For" => "ShipForID",
        "Warehouse" => "WarehouseID"
    ];

    public $headTableThree = [
        "Purchase Order" => "PurchaseOrderNumber",
        "Salesman" => "EmployeeID",
        "Ship Date" => "OrderShipDate",
        "Ship Via" => "ShipMethodID",
        "Terms" => "TermsID"
    ];

    public $detailTable = [
        "viewPath" => "AccountsReceivable/OrderProcessing/ViewQuotesDetail",
        "newKeyField" => "OrderNumber",
        "keyFields" => ["OrderNumber", "OrderLineNumber"]
    ];

    public $footerTable = [
        "flagsHeader" => [
            "Backordered" => "Backordered"
        ],
        "flags" => [
            ["Posted", "Posted", "PostedDate", "Posted Date"],
            ["Picked", "Picked", "PickedDate", "Picked Date"],
            ["Printed", "Printed", "PrintedDate", "Printed Date"],
            ["Billed", "Billed", "BilledDate", "Billed Date"],
            ["Shipped", "Shipped", "OrderShipDate", "Shipped Date"],
            ["Invoiced", "Invoiced", "InvoiceDate", "Invoice Date"]
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
		"OrderNumber" => "Order Number",
		"OrderTypeID" => "Type",
		"OrderDate" => "Order Date",
		"CustomerID" => "Customer ID",
		"CurrencyID" => "Currency ID",
		"Total" => "Total",
		"ShipDate" => "Ship Date",
		"Invoiced" => "Invoiced",
		"TransactionTypeID" => "Transaction Type ID",
		"OrderDueDate" => "Due Date",
		"OrderShipDate" => "Order Ship Date",
		"OrderCancelDate" => "Order Cancel Date",
		"SystemDate" => "System Date",
		"Memorize" => "Memorize",
		"PurchaseOrderNumber" => "Purchase Order Number",
		"TaxExemptID" => "Exempt",
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
		"ShippingName" => "Name",
		"ShippingAddress1" => "Address 1",
		"ShippingAddress2" => "Address 2",
		"ShippingAddress3" => "Address 3",
		"ShippingCity" => "City",
		"ShippingState" => "State",
		"ShippingZip" => "Zip",
		"ShippingCountry" => "Country",
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
		"TrackingNumber" => "Tracking #",
		"Billed" => "Billed",
		"BilledDate" => "Billed Date",
		"InvoiceNumber" => "Invoice #",
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
		"ManagerPassword" => "Manager Password",
        "OrderQty" => "Qty",
        "ItemID" => "Item ID",
        "Description" => "Description",
        "ItemUOM" => "UOM",
        "ItemUnitPrice" => "Price",
        "Total" => "Total",
        "GLSalesAccount" => "Sales Account",
        "ProjectID" => "ProjectID"
	];

    public $customerFields = [
        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "AccountStatus" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerAddress1" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerAddress2" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerAddress3" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerCity" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerState" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerZip" => [
            "dbType" => "varchar(10)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerCountry" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerPhone" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerFax" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerEmail" => [
            "dbType" => "varchar(60)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "Attention" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $customerIdFields = ["CompanyID","DivisionID","DepartmentID","CustomerID"];
    //getting data for Customer Page
    public function getCustomerInfo($id){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->customerFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->customerIdFields as $key){
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
            $keyFields .= " AND CustomerID='" . $id . "'";
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from customerinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($id ? $result[0] : $result), true);
        
        return $result;
    }

    public $detailIdFields = ["CompanyID","DivisionID","DepartmentID","OrderNumber", "OrderLineNumber"];
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
		"GLSalesAccount" => [
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

        $keyFields .= " AND OrderNumber='" . $id . "'";

        
        $result = DB::select("SELECT " . implode(",", $fields) . " from orderdetail " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function detailDelete(){
        $user = Session::get("user");
        $idFields = ["CompanyID","DivisionID","DepartmentID","OrderNumber", "OrderLineNumber"];
        $keyValues = explode("__", $_GET["item"]);
        $keyFields = "";
        $fcount = 0;
        foreach($idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        DB::delete("DELETE from orderdetail " .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
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

    public function recalcQuoteDetail($currencyPrecision, $allowanceDiscountPerc, $quoteDetail) {
        $DiscountPerc = $quoteDetail->DiscountPerc + $allowanceDiscountPerc;
        $Qty = $quoteDetail->OrderQty;
        $Taxable = $quoteDetail->Taxable;
        $TaxPercent = $quoteDetail->TaxPercent;
        $ItemUnitPrice = $quoteDetail->ItemUnitPrice;
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

            // for row updating OrderDetail
            "TaxAmount" => $TaxAmount,
            "Total" => $ItemTotal,
            "SubTotal" => $SubTotal
        ];
    }

    public function Recalc() {
        $user = Session::get("user");

        $orderNumber = $_POST["OrderNumber"];

        $result = DB::select("SELECT * from OrderHeader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND OrderNumber='" . $orderNumber . "'", array());

        $orderHeader = $result[0];

        $SubTotal = 0;
        $Total = 0;
        $TotalTaxable = 0;
        $TaxAmount = 0;
        $HeaderTaxAmount = 0;
        $ItemTotalTaxable = 0;
        $ItemDiscountAmount = 0;
        $DiscountAmount = 0;

        $Precision = $this->getPrecision($orderHeader->CurrencyID);

        $quoteDetails = DB::select("SELECT * from OrderDetail WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND OrderNumber='" . $orderNumber . "'", array());
        foreach($quoteDetails as $quoteDetail) {
            $detailResult = $this->recalcQuoteDetail($Precision, $orderHeader->AllowanceDiscountPerc, $quoteDetail);
            $SubTotal += $detailResult["SubTotal"];
            $Total += $detailResult["Total"];
            $TotalTaxable += $detailResult["ItemTotalTaxable"];
            $DiscountAmount += $detailResult["ItemDiscountAmount"];
            $TaxAmount += $detailResult["TaxAmount"];

            DB::update("UPDATE OrderDetail set TaxAmount='" . $detailResult["TaxAmount"] . "', Total='" . $detailResult["Total"] . "', SubTotal='" . $detailResult["SubTotal"] . "' WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND OrderLineNumber='" . $quoteDetail->OrderLineNumber ."'");
        }

        $Handling = $orderHeader->Handling;
        $HeaderTaxPercent = $orderHeader->TaxPercent;

        if($Handling > 0) {
            $HeaderTaxAmount = round($Handling * $HeaderTaxPercent / 100, $Precision);
        }

        $Freight = $orderHeader->Freight;
        $TaxFreight = $orderHeader->TaxFreight;

        if (($Freight > 0) && ($TaxFreight == "1")) {
            $HeaderTaxAmount = round($HeaderTaxAmount + $Freight * $HeaderTaxPercent / 100, $Precision);
        }

        $Total += ($Handling + $Freight + $HeaderTaxAmount);

        DB::update("UPDATE OrderHeader set SubTotal='" . $SubTotal . "', DiscountAmount='" . $DiscountAmount . "', TaxableSubTotal='" . $TotalTaxable . "', BalanceDue='" . round($Total - $orderHeader->AmountPaid, $Precision) ."', TaxAmount='" .($TaxAmount + $HeaderTaxAmount) . "', Total='" . $Total . "' WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND OrderNumber='" . $orderNumber ."'");
    }

    public function getPage($id){
        if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "last24"){
            $this->gridConditions .= "and OrderDate >= now() - INTERVAL 1 DAY";
            $result = parent::getPage($id);
            return $result;
        }else{
            $result = parent::getPage($id);
            return $result;
        }
    }
    
    public function Order_CreateFromQuote() {
        $user = Session::get("user");

        DB::statement("CALL Order_CreateFromQuote('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["OrderNumber"] . "',@SWP_RET_VALUE)");

        $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');

        if($result[0]->SWP_RET_VALUE == -1) {
            http_response_code(400);
            echo $result[0]->SWP_RET_VALUE;
        } else {
            echo "ok";
        }
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
}

class QuoteHeaderMemorizedList extends QuoteHeaderList{
	public $gridConditions = "(LOWER(IFNULL(OrderHeader.TransactionTypeID,N'')) NOT IN ('return', 'service order', 'order')) AND Memorize=1";
	public $dashboardTitle ="Memorized Quotes";
	public $breadCrumbTitle ="Memorized Quotes";
    public $modes = ["grid", "view"];
    public $features = ["selecting"];

    public function Order_CreateFromMemorized(){
        $user = Session::get("user");

        $numbers = explode(",", $_POST["OrderNumbers"]);
        $success = true;
        foreach($numbers as $number){
            DB::statement("CALL Order_CreateFromMemorized('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $number . "', @message, @SWP_RET_VALUE)", array());

            $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE, @message as message', array());
            if($result[0]->SWP_RET_VALUE == -1)
                $success = false;
        }

        if($success)
            echo $result[0]->message;
        else {
            http_response_code(400);
            echo $result[0]->SWP_RET_VALUE;
        }
    }
}

?>
