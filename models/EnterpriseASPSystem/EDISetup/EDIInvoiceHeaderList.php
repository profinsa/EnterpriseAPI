<?php
/*
  Name of Page: EDI Invoice

  Method: Model for grid and detail sceens. It provides data from database and default values, column names and categories

  Date created: 19/02/2019 Zaharov Nikita

  Use: this model used by gridView for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by controllers
  used as model by 

  Calls:
  MySql Database

  Last Modified: 21/02/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/excelImport.php";
require "./models/gridDataSource.php";

class EDIInvoiceHeaderList extends gridDataSource{
    public $tableName = "ediinvoiceheader";
    public $dashboardTitle ="EDI Invoices";
    public $breadCrumbTitle ="EDI Invoices";
	public $idField ="InvoiceNumber";
	public $idFields = ["CompanyID","DivisionID","DepartmentID", "InvoiceNumber"];
    public $features = ["selecting"];
    public $gridFields = [
        "InvoiceNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        /*        "OrderNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
            ],*/
        "EDIDirectionTypeID" => [
            "dbType" => "varchar(1)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "InvoiceDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CurrencyID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "Total" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "Errors" => [
            "dbType" => "varchar(255)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        /*        "ShipDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "TrackingNumber" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
            ],*/
    ];

    public $editCategories = [
        "Main" => [
            "InvoiceNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => "(new)",
                "dirtyAutoincrement" => "true"
            ],
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
            "EDIDirectionTypeID" => [
                "dbType" => "varchar(1)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EDIDocumentTypeID" => [
                "dbType" => "varchar(3)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EDIOpen" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "TransOpen" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "InvoiceTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "InvoiceDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "InvoiceDueDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "InvoiceShipDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "InvoiceCancelDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "PurchaseOrderNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TaxExemptID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TaxGroupID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Errors" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Customer" => [
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerShipToID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerShipForID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WarehouseID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerDropShipment" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
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
            "ShipMethodID" => [
                "dbType" => "varchar(15)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Additional" => [
            "EmployeeID" => [
                "dbType" => "varchar(15)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TermsID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PaymentMethodID" => [
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
            ],
            "GLSalesAccount" => [
                "dbType" => "varchar(36)",
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
                "dbType" => "varchar(15)",
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
            "Backordered" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
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
            "AllowanceDiscountPerc" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "...fields" => [
            "InvoiceNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => "(new)",
                "dirtyAutoincrement" => "true" 
           ],
            "OrderNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true"
            ],
            "InvoiceDate" => [
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
                "dataProvider" => "getCustomers",
                "fieldsToFill" => [
                    "TermsID" => "TermID",
                    "CustomerShipToID" => "ShipToID",
                    //                 "CustomerShipForID" => "ShipForID",
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
				"defaultValue" => "Invoice"
			],
			"InvoiceCancelDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
            /*			"ShipForID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getShipForIDS",
                "dataProviderArgs" => ["CustomerID", "ShipToID"],
				"defaultValue" => ""
                ],*/
            /*			"ShipToID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getShipToIDS",
                "dataProviderArgs" => ["CustomerID"],
				"defaultValue" => ""
                ],*/
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
			"EmployeeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
				"defaultValue" => ""
			],
            "InvoiceShipDate" => [
				"dbType" => "timestamp",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"InvoiceCancelDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
            /*			"SystemDate" => [
				"dbType" => "timestamp",
				"inputType" => "datetime",
				"defaultValue" => "now"
                ],*/
            /*			"Memorize" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0",
                "disabledEdit" => "true"
                ],*/
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
            /*			"CashTendered" => [
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
        "Invoice Number" => "InvoiceNumber",
        "Invoice Date" => "InvoiceDate",
        "Order Number" => "OrderNumber",
        "Transaction Type" => "TransactionTypeID",
        "Cancel Type" => "InvoiceCancelDate"
    ];

    public $headTableTwo = [
        "Customer ID" => "CustomerID",
        //"Ship To" => "ShipToID",
        //        "Ship For" => "ShipForID",
        "Warehouse" => "WarehouseID"
    ];

    public $headTableThree = [
        "Purchase Order" => "PurchaseOrderNumber",
        "Salesman" => "EmployeeID",
        "Ship Date" => "InvoiceShipDate",
        "Ship Via" => "ShipMethodID",
        "Terms" => "TermsID"
    ];

    public $detailTable = [
        "viewPath" => "SystemSetup/EDISetup/InvoiceDetail",
        "newKeyField" => "InvoiceNumber",
        "keyFields" => ["InvoiceNumber", "InvoiceLineNumber"]
    ];

    public $footerTable = [
        "flagsHeader" => [
            "Backordered" => "Backordered",
            //            "Memorized" => "Memorize"
        ],
        "flags" => [
            ["Posted", "Posted", "PostedDate", "Posted Date"],
            ["Picked", "Picked", "PickedDate", "Picked Date"],
            ["Printed", "Printed", "PrintedDate", "Printed Date"],
            ["Billed", "Billed", "BilledDate", "Billed Date"],
            ["Shipped", "Shipped", "InvoiceShipDate", "Shipped Date"]
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
        "InvoiceNumber" => "Invoice Number",
        "OrderNumber" => "Order Number",
        "TransactionTypeID" => "Transaction Type ID",
        "EDIDirectionTypeID" => "EDI Direction Type ID",
        "EDIDocumentTypeID" => "EDI Document Type ID",
        "EDIOpen" => "EDI Open",
        "TransOpen" => "Trans Open",
        "InvoiceTypeID" => "Invoice Type ID",
        "InvoiceDate" => "Invoice Date",
        "InvoiceDueDate" => "Invoice Due Date",
        "InvoiceShipDate" => "Invoice Ship Date",
        "InvoiceCancelDate" => "Invoice Cancel Date",
        "PurchaseOrderNumber" => "Purchase Order Number",
        "TaxExemptID" => "TaxExempt ID",
        "TaxGroupID" => "TaxGroup ID",
        "CustomerID" => "Customer ID",
        "CustomerShipToID" => "Customer Ship To ID",
        "CustomerShipForID" => "CustomerShip For ID",
        "WarehouseID" => "Warehouse ID",
        "CustomerDropShipment" => "Customer Drop Shipment",
        "ShippingName" => "Shipping Name",
        "ShippingAddress1" => "Shipping Address 1",
        "ShippingAddress2" => "Shipping Address 2",
        "ShippingCity" => "Shipping City",
        "ShippingState" => "Shipping State",
        "ShippingZip" => "Shipping Zip",
        "ShippingCountry" => "Shipping Country",
        "ShipMethodID" => "Ship Method ID",
        "EmployeeID" => "Employee ID",
        "TermsID" => "Terms ID",
        "PaymentMethodID" => "Payment Method ID",
        "CurrencyID" => "Currency ID",
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
        "Total" => "Total",
        "AmountPaid" => "Amount Paid",
        "BalanceDue" => "Balance Due",
        "UndistributedAmount" => "Undistributed Amount",
        "Commission" => "Commission",
        "CommissionableSales" => "Commissionable Sales",
        "ComissionalbleCost" => "Comissionalble Cost",
        "GLSalesAccount" => "GL Sales Account",
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
        "Picked" => "Picked",
        "PickedDate" => "Picked Date",
        "Billed" => "Billed",
        "BilledDate" => "Billed Date",
        "Printed" => "Printed",
        "PrintedDate" => "Printed Date",
        "Shipped" => "Shipped",
        "ShipDate" => "Ship Date",
        "TrackingNumber" => "Tracking #",
        "Backordered" => "Backordered",
        "Posted" => "Posted",
        "PostedDate" => "Posted Date",
        "HeaderMemo1" => "Header Memo 1",
        "HeaderMemo2" => "Header Memo 2",
        "HeaderMemo3" => "Header Memo 3",
        "HeaderMemo4" => "Header Memo 4",
        "HeaderMemo5" => "Header Memo 5",
        "HeaderMemo6" => "Header Memo 6",
        "HeaderMemo7" => "Header Memo 7",
        "HeaderMemo8" => "Header Memo 8",
        "HeaderMemo9" => "Header Memo 9",
        "AllowanceDiscountPerc" => "Allowance Discount Perc",
        "OrderQty" => "Qty",
        "ItemID" => "Item ID",
        "Description" => "Description",
        "ItemUOM" => "UOM",
        "ItemUnitPrice" => "Price",
        "Total" => "Total",
        "GLSalesAccount" => "Sales Account",
        "ProjectID" => "ProjectID",
        "Errors" => "Errors"
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

        $result = json_decode(json_encode($id ? (count($result) ? $result[0] : null) : $result), true);
        
        return $result;
    }

    public $detailIdFields = ["CompanyID","DivisionID","DepartmentID","InvoiceNumber", "InvoiceLineNumber"];
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

        $keyFields .= " AND InvoiceNumber='" . $id . "'";

        
        $result = DB::select("SELECT " . implode(",", $fields) . " from ediinvoicedetail " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function detailDelete(){
        $user = Session::get("user");
        $idFields = ["CompanyID","DivisionID","DepartmentID","InvoiceNumber", "InvoiceLineNumber"];
        $keyValues = explode("__", $_GET["item"]);
        $keyFields = "";
        $fcount = 0;
        foreach($idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        DB::delete("DELETE from ediinvoicedetail " .   ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());
    }

    public function uploadExcel(){
        $user = Session::get("user");
        $excelImport = new excelImport();
        $correctNamesToEDI = [
            "TransactionDate" => "InvoiceDate",
            "Transaction Number" => "InvoiceNumber",
            "Customer ID" => "CustomerID",
            "Customer Name" => "CustomerName",
            "Item ID" => "ItemID",
            "ItemName" => "Description",
            "Quantity" => "OrderQty" ,
            "Unit Price" => "ItemUnitPrice",
            "Total Amount" => "Total",
            "Payment Method" => "PaymentMethodID",
            "Currency" => "CurrencyID",
            "Exchange Rate" => "CurrencyExchangeRate"
        ];
        $rowsWithNames = [];
        if(isset($_FILES['file'])){
            $rowsWithNames = $excelImport->getDataFromUploadedFile($correctNamesToEDI);
            //FIXME checking on existing records in ediinvoiceheader
            foreach($rowsWithNames as $row){
                if(!count(DB::select("select * from ediinvoiceheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND InvoiceNumber=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $row["InvoiceNumber"]]))){
            
                    DB::insert("insert into ediinvoiceheader (CompanyID, DivisionID, DepartmentID, InvoiceNumber, InvoiceDate, CustomerID, PaymentMethodID, CurrencyID, CurrencyExchangeRate, Total) values('{$user["CompanyID"]}', '{$user["DivisionID"]}', '{$user["DepartmentID"]}', '{$row["InvoiceNumber"]}', '{$row["InvoiceDate"]}', '{$row["CustomerID"]}', '{$row["PaymentMethodID"]}', '{$row["CurrencyID"]}', '{$row["CurrencyExchangeRate"]}', '{$row["Total"]}')", array());
                    DB::insert("insert into ediinvoicedetail (CompanyID, DivisionID, DepartmentID, InvoiceNumber, ItemID, Description, CurrencyID, CurrencyExchangeRate, OrderQty, ItemUnitPrice, Total) values('{$user["CompanyID"]}', '{$user["DivisionID"]}', '{$user["DepartmentID"]}', '{$row["InvoiceNumber"]}', '{$row["ItemID"]}', '{$row["Description"]}', '{$row["CurrencyID"]}', '{$row["CurrencyExchangeRate"]}', '{$row["OrderQty"]}', '{$row["ItemUnitPrice"]}', '{$row["Total"]}')", array());
                }
            }
            
            if(empty($errors) == true) 
                echo "ok";
            else{
                http_response_code(400);
                echo implode("&&", $errors);
            }
        }else{
            http_response_code(400);
            echo "failed";
        }
    }

    public $postHeaderFields = [
        "CompanyID",
        "DivisionID",
        "DepartmentID",
        "InvoiceNumber",
        "InvoiceDate",
        "CustomerID",
        "Total",
        "PaymentMethodID",
        "CurrencyID",
        "CurrencyExchangeRate"
    ];
    
    public $postDetailFields = [
        "CompanyID",
        "DivisionID",
        "DepartmentID",
        "InvoiceNumber",
        "ItemID",
        "Description",
        "OrderQty" ,
        "ItemUnitPrice",
        "Total",
        "CurrencyID",
        "CurrencyExchangeRate"
    ];

    public function checkRecordsForCustomer($tablesFrom, $keyField, &$records){
        $user = Session::get("user");
        
        foreach($records as &$record){
            $customerRecord = (array)DB::select("select CustomerID from customerinformation WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND CustomerID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $record["header"]["CustomerID"]]);
            if(!count($customerRecord)){
                DB::update("UPDATE {$tablesFrom["header"]} SET Errors = 'Customer not found. ' WHERE $keyField=?", [$record["header"][$keyField]]);
                $record["error"] = true;
            }else{
                DB::update("UPDATE {$tablesFrom["header"]} SET Errors = '' WHERE $keyField=?", [$record["header"][$keyField]]);
            }
            //echo "Customer {$record["header"]["CustomerID"]} not found\n";
        }
    }

    public function checkRecordsForItem($tablesFrom, $keyField, &$records){
        $user = Session::get("user");

        foreach($records as &$record){
            $customerRecord = (array)DB::select("select ItemID from inventoryitems WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ItemID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $record["detail"]["ItemID"]]);
            if(!count($customerRecord)){
                DB::update("UPDATE {$tablesFrom["header"]} SET Errors = CONCAT(IFNULL(Errors,''), 'Item not found. ') WHERE $keyField=?", [$record["header"][$keyField]]);
                $record["error"] = true;
            //echo "Item {$record["detail"]["ItemID"]} not found\n";
            }
        }
    }

    public function copyRecordsToAnotherTable($tablesFrom, $tablesTo, $headerFields, $detailFields, $keyField, $keys){
        $user = Session::get("user");
        $records = [];
        $postedNumbers = [];

        foreach($keys as $key){
            $header = (array)DB::select("select * from {$tablesFrom["header"]} WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND $keyField=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $key])[0];
            $detail = (array)DB::select("select * from {$tablesFrom["detail"]} WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND $keyField=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $key])[0];
            
            $records[] = [
                "header" => $header,
                "detail" => $detail
            ];
        }

        $this->checkRecordsForCustomer(
            [
                "header" => $tablesFrom["header"],
                "detail" => $tablesFrom["detail"]
            ],
            $keyField,
            $records);
        $this->checkRecordsForItem(
            [
                "header" => $tablesFrom["header"],
                "detail" => $tablesFrom["detail"]
            ],
            $keyField,
            $records);
        
        foreach($records as $record){
            if(!count(DB::select("select * from {$tablesTo["header"]} WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND $keyField=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $record["header"][$keyField]]))&&
               !key_exists("error", $record)
            ){
                $postedNumbers[] = $record["header"][$keyField];
                $insertHeaderValues = [];
                foreach($headerFields as $key){
                    if($key == "CompanyID")
                        $insertHeaderValues[] = "'{$user["CompanyID"]}'";
                    else if($key == "DivisionID")
                        $insertHeaderValues[] = "'{$user["DivisionID"]}'";
                    else if($key == "CompanyID")
                        $insertHeaderValues[] = "'{$user["DivisionID"]}'";
                    else
                        $insertHeaderValues[] = "'{$record["header"][$key]}'";
                }
                $insertDetailValues = [];
                foreach($detailFields as $key){
                    if($key == "CompanyID")
                        $insertDetailValues[] = "'{$user["CompanyID"]}'";
                    else if($key == "DivisionID")
                        $insertDetailValues[] = "'{$user["DivisionID"]}'";
                    else if($key == "CompanyID")
                        $insertDetailValues[] = "'{$user["DivisionID"]}'";
                    else
                        $insertDetailValues[] = "'{$record["detail"][$key]}'";
                }
                
                //echo "insert into {$tablesTo["header"]} (" . implode(',', $headerFields) . ") values (" . implode(',', $insertHeaderValues) . ")\n";
                //echo "insert into {$tablesTo["detail"]} (" . implode(',', $detailFields) . ") values (" . implode(',', $insertDetailValues) . ")\n";
                DB::insert("insert into {$tablesTo["header"]} (" . implode(',', $headerFields) . ") values (" . implode(',', $insertHeaderValues) . ")", []);
                //usleep(500);
                DB::insert("insert into {$tablesTo["detail"]} (" . implode(',', $detailFields) . ") values (" . implode(',', $insertDetailValues) . ")", []);
            }
        }

        return $postedNumbers;
    }
    

    public function WriteErrors(){
        $user = Session::get("user");

        foreach($_POST as $number=>$value)
            if($value != "ok")
                DB::update("UPDATE ediinvoiceheader SET Errors = CONCAT(IFNULL(Errors,''), '$value. ') WHERE InvoiceNumber=?", [$number]);
            else
                DB::delete("DELETE from ediinvoiceheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND InvoiceNumber=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $number]);
    }
    /*
      plan
      rename Post to Copy or something like that
     */

    public function PostSelected(){
        $user = Session::get("user");

        $numbers = explode(",", $_POST["InvoiceNumbers"]);
        //FIXME checking on existing records in invoiceheader
        $success = true;
        $postedNumbers = $this->copyRecordsToAnotherTable(
            [
                "header" => "ediinvoiceheader",
                "detail" => "ediinvoicedetail"
            ],
            [
                "header" => "invoiceheader",
                "detail" => "invoicedetail"
            ],
            $this->postHeaderFields,
            $this->postDetailFields,
            "InvoiceNumber",
            $numbers
        );

        echo json_encode($postedNumbers, JSON_PRETTY_PRINT);
    }
    
    public function PostAll(){
        $user = Session::get("user");

        $numberRecords = DB::select("select InvoiceNumber from ediinvoiceheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        //FIXME checking on existing records in invoiceheader
        $numbers = [];
        foreach($numberRecords as $record)
            $numbers[] = $record->InvoiceNumber;

        $postedNumbers = $this->copyRecordsToAnotherTable(
            [
                "header" => "ediinvoiceheader",
                "detail" => "ediinvoicedetail"
            ],
            [
                "header" => "invoiceheader",
                "detail" => "invoicedetail"
            ],
            $this->postHeaderFields,
            $this->postDetailFields,
            "InvoiceNumber",
            $numbers
        );

        echo json_encode($postedNumbers, JSON_PRETTY_PRINT);
   }
}
?>
