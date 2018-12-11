<?php
/*
  Name of Page: PurchaseContractHeaderHistoryList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\PurchaseContract\PurchaseContractHeaderHistoryList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/PurchaseContractHeaderHistoryList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\PurchaseContract\PurchaseContractHeaderHistoryList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\PurchaseContract\PurchaseContractHeaderHistoryList.php
   
  Calls:
  MySql Database
   
  Last Modified: 12/11/2018
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
	public $tableName = "purchasecontractheaderhistory";
	public $dashboardTitle ="View Purchase Contracts History";
	public $breadCrumbTitle ="View Purchase Contracts History";
	public $idField ="PurchaseContractNumber";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","PurchaseContractNumber"];
    public $modes = ["grid", "view"];
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
				"inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
				"defaultValue" => ""
			],
			"ApprovedDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"EnteredBy" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
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
			"PurchaseContractNumber" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => "",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => "(new)",
                "dirtyAutoincrement" => "true"
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
            "VendorID" => [
                "dbType" => "varchar(50)",
                "inputType" => "dialogChooser",
                "dataProvider" => "getVendors",
                "defaultValue" => "DEFAULT",
                "defaultOverride" => true
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "text"
            ],
			"TransactionTypeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getARTransactionTypes",
				"defaultValue" => "Purchase Contract",
                "defaultOverride" => true
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
            "ShipDate" => [
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
	public $columnNames = [

		"PurchaseContractDate" => "Contract Date",
		"TransactionTypeID" => "Transaction Type ID",
		"CurrencyID" => "Currency ID",
		"Total" => "Total",
		"ShipDate" => "Ship Date",
		"PurchaseContractNumber" => "Purchase Contract Number",
		"PurchaseContractDueDate" => "Purchase Contract Due Date",
		"PurchaseContractStartDate" => "Purchase Contract Start Date",
		"PurchaseContractEndDate" => "Purchase Contract End Date",
		"PurchaseDateRequested" => "Purchase Date Requested",
		"SystemDate" => "System Date",
		"Memorize" => "Memorize",
		"OrderNumber" => "Order Number",
		"VendorInvoiceNumber" => "Vendor Invoice Number",
		"OrderedBy" => "Ordered By",
		"TaxExemptID" => "Tax Exempt ID",
		"TaxGroupID" => "Tax Group ID",
		"VendorID" => "Vendor ID",
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
		"PurchaseContractOpen" => "Purchase Contract Open"
	];
}
?>
