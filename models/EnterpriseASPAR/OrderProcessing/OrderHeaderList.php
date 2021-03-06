<?php
/*
  Name of Page: OrderHearderList model
   
  Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\OrderProcessing\OrderHearderList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Zaharov Nikita
   
  Use: this model used by views/OrderHearderList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\OrderProcessing\OrderHearderList.php
  used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\OrderProcessing\OrderHearderList.php
   
  Calls:
  MySql Database
   
  Last Modified: 22/04/2020
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
require "./models/helpers/recalc.php";

class OrderHeaderList extends gridDataSource{
	public $tableName = "orderheader";
	public $gridConditions = "(LOWER(IFNULL(OrderHeader.TransactionTypeID, N'')) NOT IN ('return', 'service order', 'quote')) AND (LOWER(IFNULL(OrderHeader.OrderTypeID, N'')) <> 'hold') AND (IFNULL(Picked, 0) = 0) AND (IFNULL(Shipped, 0) = 0) AND (IFNULL(Backordered, 0) = 0) AND (IFNULL(Invoiced, 0) = 0)";
	public $dashboardTitle ="Orders";
	public $breadCrumbTitle ="Orders";
    public $docType = "order";
	public $idField ="OrderNumber";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","OrderNumber"];
    public $id = "";
	public $gridFields = [
		"OrderNumber" => [
			"dbType" => "varchar(36)",
			"inputType" => "text",
            "disabledEdit" => "true"
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
        ],
		"Invoiced" => [
			"dbType" => "tinyint(1)",
			"inputType" => "checkbox"
		],
		"InvoiceNumber" => [
			"dbType" => "varchar(36)",
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
				"inputType" => "dropdown",
                "dataProvider" => "getShipMethods",
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
			]/*,
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
				"inputType" => "textarea",
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
                "defaultOverride" => true,
                "defaultValue" => "",
                "required" => "true",
                "inputType" => "dialogChooser",
                "dataProvider" => "getCustomers",
                "fieldsToFill" => [
                    "TermsID" => "TermID",
                    "CustomerShipToID" => "ShipToID",
                    "CustomerShipForID" => "ShipForID",
                    "CurrencyID" => "CurrencyID",
                    //                    CASE
                    //WHEN IFNULL(CurrencyID,N'') = N'' THEN v_CompanyCurrencyID
                    //ELSE CurrencyID
                    //END 	AS CurrencyID,
                    "TaxGroupID" => "TaxGroupID",
                    "TaxIDNo" => "TaxIDNo",
                    "WarehouseID" => "WarehouseID",
                    "ShipMethodID" => "ShipMethodID",
                    "EmployeeID" => "EmployeeID",
                    "GLSalesAccount" => "GLSalesAccount",
                    "CustomerName" => "ShippingName",
                    "CustomerAddress1" => "ShippingAddress1",
                    "CustomerAddress2" => "ShippingAddress2",
                    "CustomerAddress3" => "ShippingAddress3",
                    "CustomerCity" => "ShippingCity",
                    "CustomerState" => "ShippingState",
                    "CustomerZip" => "ShippingZip",
                    "CustomerCountry" => "ShippingCountry",
                    //IFNULL(Terms.NetDays,0) As NetDays,
                    //v_AllowanceDiscountPercent AS AllowanceDiscountPerc
                ]
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
				"defaultValue" => "Order"
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
				"defaultValue" => ""
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
			],
			"HeaderMemo1" => [
				"dbType" => "varchar(50)",
				"inputType" => "textarea",
				"defaultValue" => ""
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
        "viewPath" => "AccountsReceivable/OrderProcessing/ViewOrdersDetail",
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
        if(!$id)
            $id = "DEFAULT";
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
            "inputType" => "dropdown",
            "dataProvider" => "getAccounts"
		],
		"ProjectID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		]
	];

    public function Recalc() {
        $recalc = new recalcHelper;

        $recalc->recalcOrder(Session::get("user"), $_POST["OrderNumber"]);

        echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
    }

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

    public function Post(){
        $user = Session::get("user");

        $result = DB::callProcedureOrFunction("Order_Post",
                                              [
                                                  "CompanyID" => $user["CompanyID"],
                                                  "DivisionID" => $user["DivisionID"],
                                                  "DepartmentID" => $user["DepartmentID"],
                                                  "OrderNumber" => $_POST["OrderNumber"]
                                              ]);
        
        if($result->ReturnValue == -1) {
            http_response_code(400);
            echo json_encode(["message" => $result->PostingResult], JSON_PRETTY_PRINT);
        } else 
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
        
        //         DB::statement("CALL Order_Post2('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["OrderNumber"] . "',@PostingResult,@SWP_RET_VALUE)");
    }

    public function UnPost(){
        $user = Session::get("user");

        $result = DB::callProcedureOrFunction("Order_Cancel",
                                              [
                                                  "CompanyID" => $user["CompanyID"],
                                                  "DivisionID" => $user["DivisionID"],
                                                  "DepartmentID" => $user["DepartmentID"],
                                                  "OrderNumber" => $_POST["OrderNumber"]
                                              ]);
        
        if($result->ReturnValue == -1) {
            http_response_code(400);
            echo json_encode($result, JSON_PRETTY_PRINT);
        } else 
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
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
        echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
    }

    public function contractCreateFromOrder() {
        $user = Session::get("user");

        $result = DB::callProcedureOrFunction("Contract_CreateFromOrder",
                                              [
                                                  "CompanyID" => $user["CompanyID"],
                                                  "DivisionID" => $user["DivisionID"],
                                                  "DepartmentID" => $user["DepartmentID"],
                                                  "OrderNumber" => $_POST["OrderNumber"]
                                              ]);
        
        if($result->ReturnValue == -1) {
            http_response_code(400);
            echo json_encode($result, JSON_PRETTY_PRINT);
        } else 
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
    }
    
    public function getPage($id){
        $user = Session::get("user");
        if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "last24"){
            $this->gridConditions .= "and OrderDate >= now() - INTERVAL 1 DAY";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "shiptoday"){
            $this->gridConditions = "ShipDate >= now() - INTERVAL 1 DAY AND ShipDate <= NOW()";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "shipthismonth"){
            $this->gridConditions = "ShipDate > LAST_DAY(NOW()) - INTERVAL 1 MONTH AND ShipDate < LAST_DAY(NOW()) + INTERVAL 1 DAY";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "total"){
            $this->gridConditions = "1=1";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("ShipDate", $_GET)){
            $ShipDate = $_GET["ShipDate"];
            //            $ShipDate = date("Y-m-d H:i:s", strtotime($_GET["ShipDate"]));
            $this->gridConditions = "(LOWER(IFNULL(OrderHeader.TransactionTypeID, N'')) NOT IN ('return', 'service order', 'quote')) AND date(ShipDate)='$ShipDate'";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("ItemID", $_GET)){
            $ItemID = $_GET["ItemID"];
            $result = DB::select("select DISTINCT orderheader.OrderNumber, orderheader.CompanyID, orderheader.DivisionID, orderheader.DepartmentID, orderheader.OrderNumber, orderheader.OrderTypeID, orderheader.OrderDate, orderheader.CustomerID, orderheader.CurrencyID, orderheader.Total, orderheader.ShipDate, orderheader.TrackingNumber, orderheader.Invoiced, orderheader.InvoiceNumber from orderdetail inner join orderheader on orderdetail.OrderNumber=orderheader.OrderNumber AND orderdetail.CompanyID=orderheader.CompanyID AND orderdetail.DivisionID=orderheader.DivisionID AND orderdetail.DepartmentID=orderheader.DepartmentID where orderheader.CompanyID=? AND orderheader.DivisionID=? AND orderheader.DepartmentID=? AND orderdetail.ItemID=? AND orderheader.Shipped=0 AND orderheader.TransactionTypeID='Order' AND orderheader.Posted=1", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $ItemID]);

            $result = json_decode(json_encode($result), true);
        //            $result = parent::getPage($id);
            return $result;
        }else{
            $result = parent::getPage($id);
            return $result;
        }
    }
}

class OrderHeaderSimpleList extends OrderHeaderList {
	public $dashboardTitle ="Quick Order";
	public $breadCrumbTitle ="Quick Order";
	public $reportType = "order";

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
            "currencySymbol" => true,
            "inputType" => "text"
        ],
		"CurrencyID" => [
			"dbType" => "varchar(3)",
			"inputType" => "text"
		],
		"Total" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "currencySymbol" => true,
            "inputType" => "text"
		],
		"GLSalesAccount" => [
			"dbType" => "varchar(36)",
            "inputType" => "dropdown",
            "dataProvider" => "getAccounts"
		],
		"ProjectID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		]
	];
    
    // simple form section
    public $simpleInterface = [
        "showShipping" => true,
        "customerTitle" => "Name / Address",
        "customerFields" => [
            "CustomerName" => "Name",
            "CustomerAddress1" => "Address 1",
            "CustomerAddress2" => "Address 2",
            "CustomerAddress3" => "Address 3",
            "CustomerCity" => "City",
            "CustomerCountry" => "Country",
            "CustomerState" => "State",
            "CustomerZip" => "Zip"
        ],
        "shippingFields" => [
            "CustomerName" => "ShippingName",
            "CustomerAddress1" => "ShippingAddress1",
            "CustomerAddress2" => "ShippingAddress2",
            "CustomerAddress3" => "ShippingAddress3",
            "CustomerCity" => "ShippingCity",
            "CustomerCountry" => "ShippingCountry",
            "CustomerState" => "ShippingState",
            "CustomerZip" => "ShippingZip"
        ],
        "aboutOrder" => [
            "Order Number" => "OrderNumber",
            "Order Date" => "OrderDate"
        ],
        "totalFields" => [
            "Sub-Total" => "Subtotal",
            "Tax" => "TaxAmount",
            "Total" => "Total"
        ],
        "aboutPurchase" => [
            "Purchase Order" => "PurchaseOrderNumber",
            "Salesman" => "EmployeeID"
        ]
    ];
};

class OrderHeaderClosedList extends OrderHeaderList {
	public $gridConditions = "(LOWER(IFNULL(OrderHeader.TransactionTypeID,N'')) NOT IN ('return', 'service order', 'quote')) AND (OrderHeader.Invoiced = 1)";
	public $dashboardTitle ="Closed Orders";
	public $breadCrumbTitle ="Closed Orders";
    public $modes = ["grid", "view"];
    public $features = ["selecting"]; //list enabled features

    public function CopyToHistory(){
        $user = Session::get("user");

        $numbers = explode(",", $_POST["OrderNumbers"]);
        $success = true;
        foreach($numbers as $number){
            $result = DB::callProcedureOrFunction("Order_CopyToHistory",
                                                  [
                                                      "CompanyID" => $user["CompanyID"],
                                                      "DivisionID" => $user["DivisionID"],
                                                      "DepartmentID" => $user["DepartmentID"],
                                                      "OrderNumber" => $number
                                                  ]);
        
            if($result->ReturnValue == -1)
                $success = false;
        }

        if($success)
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
        else {
             http_response_code(400);
             echo json_encode($result, JSON_PRETTY_PRINT);
        }
    }
    
    public function CopyAllToHistory(){
        $user = Session::get("user");
 
        $result = DB::callProcedureOrFunction("Order_CopyAllToHistory",
                                              [
                                                  "CompanyID" => $user["CompanyID"],
                                                  "DivisionID" => $user["DivisionID"],
                                                  "DepartmentID" => $user["DepartmentID"]
                                              ]);
        
        if($result->ReturnValue <= -1) {
            http_response_code(400);
            echo json_encode($result, JSON_PRETTY_PRINT);
        } else 
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
   }
}

class OrderHeaderBackList extends OrderHeaderList{
	public $gridConditions = "(LOWER(IFNULL(OrderHeader.TransactionTypeID,N'')) NOT IN ('return', 'service order', 'quote')) AND (LOWER(IFNULL(OrderHeader.OrderTypeID,N'')) <> 'hold') AND (IFNULL(OrderHeader.Backordered, 0) = 1)";	
	public $dashboardTitle ="Back Orders";
	public $breadCrumbTitle ="Back Orders";
    public $modes = ["grid", "view", "edit"];

    public function allocate() {
        $user = Session::get("user");

       $result = DB::callProcedureOrFunction("Order_Allocate",
                                              [
                                                  "CompanyID" => $user["CompanyID"],
                                                  "DivisionID" => $user["DivisionID"],
                                                  "DepartmentID" => $user["DepartmentID"],
                                                  "OrderNumber" => $_POST["OrderNumber"]
                                              ]);
        
        if($result->ReturnValue == -1) {
            http_response_code(400);
            echo json_encode($result, JSON_PRETTY_PRINT);
        } else 
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT); 
    }

    public function split() {
        $user = Session::get("user");

        $result = DB::callProcedureOrFunction("Order_Split",
                                              [
                                                  "CompanyID" => $user["CompanyID"],
                                                  "DivisionID" => $user["DivisionID"],
                                                  "DepartmentID" => $user["DepartmentID"],
                                                  "OrderNumber" => $_POST["OrderNumber"]
                                              ]);        
    }
}

class OrderHeaderPickList extends OrderHeaderList{
	public $gridConditions = "(LOWER(IFNULL(OrderHeader.TransactionTypeID, N'')) NOT IN ('return', 'service order', 'quote')) AND (LOWER(IFNULL(OrderHeader.OrderTypeID, N'')) <> 'hold') AND (IFNULL(Posted, 0) = 1) AND (IFNULL(Picked, 0) = 0) AND (IFNULL(Shipped, 0) = 0) AND (IFNULL(Backordered, 0) = 0) AND (IFNULL(Invoiced, 0) = 0)";
	public $dashboardTitle ="Pick Orders";
	public $breadCrumbTitle ="Pick Orders";
    public $docType = "orderpick";
	public $modes = ["grid"];
	public $features = ["selecting"];

    public function Picked(){
        $user = Session::get("user");

        $numbers = explode(",", $_POST["OrderNumbers"]);
        $success = true;
        foreach($numbers as $number){
            $result = DB::callProcedureOrFunction("Order_Picked",
                                                  [
                                                      "CompanyID" => $user["CompanyID"],
                                                      "DivisionID" => $user["DivisionID"],
                                                      "DepartmentID" => $user["DepartmentID"],
                                                      "OrderNumber" => $number
                                                  ]);
            if($result->ReturnValue == true)
                $success = false;
        }

        if($success)
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
        else {
            http_response_code(400);
            echo json_encode(["message" => "fail"], JSON_PRETTY_PRINT);
        }
    }
    
    public function PickAll(){
        $user = Session::get("user");
        
        $result = DB::callProcedureOrFunction("Order_PickAll",
                                              [
                                                  "CompanyID" => $user["CompanyID"],
                                                  "DivisionID" => $user["DivisionID"],
                                                  "DepartmentID" => $user["DepartmentID"]
                                              ]);
        
        if($result->ReturnValue != 0) {
            http_response_code(400);
            echo json_encode($result, JSON_PRETTY_PRINT);
        } else 
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
    }
}

class OrderHeaderShipList extends OrderHeaderList{
	public $gridConditions = "(LOWER(IFNULL(OrderHeader.TransactionTypeID, N'')) NOT IN ('return', 'service order', 'quote')) AND (LOWER(IFNULL(OrderHeader.OrderTypeID, N'')) <> 'hold') AND (IFNULL(Posted, 0) = 1) AND (IFNULL(Picked, 0) = 1) AND (IFNULL(Shipped, 0) = 0) AND (IFNULL(Backordered, 0) = 0) AND (IFNULL(Invoiced, 0) = 0)";
	public $dashboardTitle ="Ship Orders";
	public $breadCrumbTitle ="Ship Orders";
	public $modes = ["grid"];
	public $features = ["selecting"];

    public function Shipped(){
        $user = Session::get("user");

        $numbers = explode(",", $_POST["OrderNumbers"]);
        $success = true;
        foreach($numbers as $number){
            $result = DB::callProcedureOrFunction("Order_Shipped",
                                                  [
                                                      "CompanyID" => $user["CompanyID"],
                                                      "DivisionID" => $user["DivisionID"],
                                                      "DepartmentID" => $user["DepartmentID"],
                                                      "OrderNumber" => $number
                                                  ]);
        
            if($result->ReturnValue == true)
                $success = false;
        }

        if($success)
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
        else {
            http_response_code(400);
            echo json_encode(["message" => "fail"], JSON_PRETTY_PRINT);
        }
    }
    
    public function ShipAll(){
        $user = Session::get("user");

        $result = DB::callProcedureOrFunction("Order_ShipAll",
                                              [
                                                  "CompanyID" => $user["CompanyID"],
                                                  "DivisionID" => $user["DivisionID"],
                                                  "DepartmentID" => $user["DepartmentID"]
                                              ]);
        
        if($result->ReturnValue != 0) {
            http_response_code(400);
            echo json_encode($result, JSON_PRETTY_PRINT);
        } else 
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);        
    }
}

class OrderHeaderShipStep2List extends OrderHeaderShipList{
	public $gridFields = [
		"OrderNumber" => [
			"dbType" => "varchar(36)",
			"inputType" => "text",
            "disabledEdit" => "true"
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
			"inputType" => "datetime",
            "editable" => true
		],
        "TrackingNumber" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => "",
            "editable" => true
        ]
	];

    public function Shipped(){
        $user = Session::get("user");
        $postData = file_get_contents("php://input");

        $data = json_decode($postData, true);
        $success = true;
        foreach($data as $row){
            DB::update("update orderheader set ShipDate=?, TrackingNumber=? WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND OrderNumber=?", [date("Y-m-d H:i:s", strtotime($row["ShipDate"])), $row["TrackingNumber"], $user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $row["OrderNumber"]]);
            $result = DB::callProcedureOrFunction("Order_Shipped",
                                                  [
                                                      "CompanyID" => $user["CompanyID"],
                                                      "DivisionID" => $user["DivisionID"],
                                                      "DepartmentID" => $user["DepartmentID"],
                                                      "OrderNumber" => $row["OrderNumber"]
                                                  ]);
        
            if($result->ReturnValue == true)
                $success = false;
        }

        if($success)
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
        else {
            http_response_code(400);
            echo json_encode(["message" => "fail"], JSON_PRETTY_PRINT);
        }
    }
}

class OrderHeaderInvoiceList extends OrderHeaderList{
	public $gridConditions = "(LOWER(IFNULL(OrderHeader.TransactionTypeID, N'')) NOT IN ('return', 'service order', 'quote')) AND LOWER(IFNULL(OrderHeader.OrderTypeID, N'')) <> 'hold' AND (OrderHeader.Shipped = 1) AND (IFNULL(OrderHeader.Invoiced,0) = 0)";
	public $modes = ["grid", "view"];
	public $features = ["selecting"];
	public $dashboardTitle ="Invoice Shipped Orders";
	public $breadCrumbTitle ="Invoice Shipped Orders";

    public function Invoice_CreateFromOrder(){
        $user = Session::get("user");

        $numbers = explode(",", $_POST["OrderNumbers"]);
        $success = true;
        foreach($numbers as $number){
            //            callStoredCode('Invoice_CreateFromOrder2', ['CompanyID', 'DivisionID', 'DepartmentID', '
            $result = DB::callProcedureOrFunction("Invoice_CreateFromOrder",
                                                  [
                                                      "CompanyID" => $user["CompanyID"],
                                                      "DivisionID" => $user["DivisionID"],
                                                      "DepartmentID" => $user["DepartmentID"],
                                                      "OrderNumber" => $number
                                                  ]);
        
            if($result->ReturnValue == true)
                $success = false;
        }

        if($success)
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
        else {
            http_response_code(400);
            echo json_encode(["message" => "fail"], JSON_PRETTY_PRINT);
        }
    }
    
    public function Invoice_AllOrders(){
        $user = Session::get("user");

        $result = DB::callProcedureOrFunction("Invoice_AllOrders",
                                              [
                                                  "CompanyID" => $user["CompanyID"],
                                                  "DivisionID" => $user["DivisionID"],
                                                  "DepartmentID" => $user["DepartmentID"]
                                              ]);
        
        if($result->ReturnValue != 0) {
            http_response_code(400);
            echo json_encode($result, JSON_PRETTY_PRINT);
        } else 
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
    }
}

class OrderHeaderHoldList extends OrderHeaderList{
	public $gridConditions = "(LOWER(IFNULL(OrderHeader.TransactionTypeID,N'')) NOT IN ('return', 'service order', 'quote')) AND (LOWER(OrderHeader.OrderTypeID) = 'hold')";
	public $dashboardTitle ="Orders On Hold";
	public $breadCrumbTitle ="Orders On Hold";
    public $modes = ["grid", "view", "edit"];

    public function releaseOnHoldOrder() {
        $user = Session::get("user");

        $result = DB::callProcedureOrFunction("Order_ReleaseOnHoldOrder",
                                              [
                                                  "CompanyID" => $user["CompanyID"],
                                                  "DivisionID" => $user["DivisionID"],
                                                  "DepartmentID" => $user["DepartmentID"],
                                                  "OrderNumber" => $_POST["OrderNumber"]
                                              ]);
        
        if($result->ReturnValue == -1) {
            http_response_code(400);
            $result->message = $result->PostingResult;
            echo json_encode($result, JSON_PRETTY_PRINT);
        } else 
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
    }
}

class OrderHeaderMemorizedList extends OrderHeaderList{
	public $gridConditions = "(LOWER(IFNULL(OrderHeader.TransactionTypeID,N'')) NOT IN ('return', 'service order', 'quote')) AND Memorize=1";
	public $dashboardTitle ="Memorized Orders";
	public $breadCrumbTitle ="Memorized Orders";
    public $modes = ["grid", "view"];
    public $features = ["selecting"];

    public function Order_CreateFromMemorized(){
        $user = Session::get("user");

        $numbers = explode(",", $_POST["OrderNumbers"]);
        $success = true;
        foreach($numbers as $number){
            $result = DB::callProcedureOrFunction("Order_CreateFromMemorized",
                                                  [
                                                      "CompanyID" => $user["CompanyID"],
                                                      "DivisionID" => $user["DivisionID"],
                                                      "DepartmentID" => $user["DepartmentID"],
                                                      "OrderNumber" => $number
                                                  ]);
        
            if($result->ReturnValue == true)
                $success = false;
        }

        if($success)
            echo json_encode(["message" => "ok"], JSON_PRETTY_PRINT);
        else {
            http_response_code(400);
            echo json_encode(["message" => "fail"], JSON_PRETTY_PRINT);
        }
    }
}

class OrderHeaderShipDateList extends OrderHeaderList{
    public $gridConditions = "";    
}
?>
