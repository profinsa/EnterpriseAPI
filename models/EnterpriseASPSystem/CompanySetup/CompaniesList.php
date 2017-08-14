<?php
/*
  Name of Page: CompaniesList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/CompaniesList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesList.php
   
  Calls:
  MySql Database
   
  Last Modified: 08/11/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
	protected $tableName = "companies";
	public $dashboardTitle ="Companies";
	public $breadCrumbTitle ="Companies";
	public $idField ="undefined";
    public $modes = ["grid", "view", "edit"];
	public $idFields = ["CompanyID","DivisionID","DepartmentID"];
	public $gridFields = [
		"CompanyName" => [
			"dbType" => "varchar(50)",
			"inputType" => "text"
		],
		"CompanyCity" => [
			"dbType" => "varchar(50)",
			"inputType" => "text"
		],
		"CompanyState" => [
			"dbType" => "varchar(50)",
			"inputType" => "text"
		],
		"CompanyZip" => [
			"dbType" => "varchar(10)",
			"inputType" => "text"
		],
		"CompanyCountry" => [
			"dbType" => "varchar(50)",
			"inputType" => "text"
		],
		"CompanyPhone" => [
			"dbType" => "varchar(30)",
			"inputType" => "text"
		]
	];

	public $editCategories = [
		"Main" => [
			"CompanyID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
                "disabledEdit" => "true",
				"defaultValue" => ""
			],
			"CompanyName" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyAddress1" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyAddress2" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyAddress3" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyCity" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyState" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyZip" => [
				"dbType" => "varchar(10)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyCountry" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyPhone" => [
				"dbType" => "varchar(30)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyFax" => [
				"dbType" => "varchar(30)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyEmail" => [
				"dbType" => "varchar(60)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyWebAddress" => [
				"dbType" => "varchar(80)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyLogoUrl" => [
				"dbType" => "varchar(120)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyLogoFilename" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyShoppingCartURL" => [
				"dbType" => "varchar(120)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyReportsDirectoryURL" => [
				"dbType" => "varchar(120)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanySupportDirectoryURL" => [
				"dbType" => "varchar(120)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyWebCRMDirectoryURL" => [
				"dbType" => "varchar(120)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CompanyNotes" => [
				"dbType" => "varchar(255)",
				"inputType" => "text",
				"defaultValue" => ""
			]
		],
		"Defaults" => [
			"CurrencyID" => [
				"dbType" => "varchar(3)",
				"inputType" => "dropdown",
                "dataProvider" => "getCurrencyTypes",
				"defaultValue" => ""
			],
			"BankAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"Terms" => [
				"dbType" => "varchar(20)",
				"inputType" => "dropdown",
                "dataProvider" => "getTerms",
				"defaultValue" => ""
			],
			"FedTaxID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"StateTaxID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"VATRegistrationNumber" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"VATSalesTaxID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"VATPurchaseTaxID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"VATOtherRegistrationNumber" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"DefaultGLPostingDate" => [
				"dbType" => "varchar(1)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"DefaultSalesGLTracking" => [
				"dbType" => "varchar(1)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"DefaultGLPurchaseGLTracking" => [
				"dbType" => "varchar(1)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"DefaultSalesTaxGroup" => [
				"dbType" => "varchar(20)",
				"inputType" => "dropdown",
                "dataProvider" => "getTaxGroups",
				"defaultValue" => ""
			],
			"DefaultPurchaseTaxGroup" => [
				"dbType" => "varchar(20)",
				"inputType" => "dropdown",
                "dataProvider" => "getTaxGroups",
				"defaultValue" => ""
			],
			"DefaultInventoryCostingMethod" => [
				"dbType" => "varchar(1)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"AgeInvoicesBy" => [
				"dbType" => "varchar(1)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"AgePurchaseOrdersBy" => [
				"dbType" => "varchar(1)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"FinanceCharge" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"FinanceChargePercent" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"WarehouseID" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getWarehouses",
				"defaultValue" => ""
			],
            /*			"WarehouseBinID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
                ],*/
			"ShippingMethod" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getShipMethods",
				"defaultValue" => ""
			],
			"ChargeHandling" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"HandlingAsPercent" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"HandlingRate" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ChargeMinimumSurcharge" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"MinimumSurchargeThreshold" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			]
		],
		"Accounts" => [
			"GLAPAccount" => [
				"dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLAPCashAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLAPInventoryAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLAPFreightAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLAPHandlingAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLAPMiscAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLAPDiscountAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLAPPrePaidAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLAPWriteOffAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLARAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLARCashAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLARSalesAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLARCOGSAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLARInventoryAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLARFreightAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLARHandlingAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLARDiscountAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLARMiscAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLARReturnAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLARWriteOffAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLFixedAccumDepreciationAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLFixedDepreciationAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLFixedAssetAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLFixedDisposalAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLBankInterestEarnedAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLBankServiceChargesAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLBankMiscWithdrawlAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLBankBankMisDepositAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLBankOtherChargesAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLRetainedEarningsAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLProfitLossAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLUnrealizedCurrencyProfitLossAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLRealizedCurrencyProfitLossAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLARFreightProfitLossAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLCurrencyGainLossAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			],
			"GLUnrealizedCurrencyGainLossAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "dropdown",
                "dataProvider" => "getAccounts",
				"defaultValue" => ""
			]
		],
		"Periods" => [
			"FiscalStartDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"FiscalEndDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"CurrentFiscalYear" => [
				"dbType" => "smallint(6)",
				"inputType" => "text",
				"defaultValue" => ""
            ],
			"CurrentPeriod" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period1Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period1Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"Period2Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period2Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"Period3Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period3Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"Period4Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period4Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"Period5Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period5Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"Period6Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period6Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"Period7Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period7Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"Period8Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period8Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"Period9Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period9Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"Period10Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period10Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"Period11Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period11Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"Period12Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period12Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"Period13Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period13Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"Period14Date" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
            ],
			"Period14Closed" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ]
/*,
            /*			"GAAPCompliant" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"EditGLTranssactions" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"EditBankTransactions" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"EditAPTransactions" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"EditARTransactions" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"HardClose" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"AuditTrail" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"PeriodPosting" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
            ],
			"SystemDates" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
                ]*/
		]
    ];
	public $columnNames = [
		"CompanyID" => "Company ID",
		"CompanyName" => "Company Name",
		"CompanyCity" => "Company City",
		"CompanyState" => "Company State",
		"CompanyZip" => "Company Zip",
		"CompanyCountry" => "Company Country",
		"CompanyPhone" => "Company Phone",
		"CompanyAddress1" => "Company Address 1",
		"CompanyAddress2" => "Company Address 2",
		"CompanyAddress3" => "Company Address 3",
		"CompanyFax" => "Company Fax",
		"CompanyEmail" => "Company Email",
		"CompanyWebAddress" => "Company Web Address",
		"CompanyLogoUrl" => "Company Logo Url",
		"CompanyLogoFilename" => "Company Logo Filename",
		"CompanyShoppingCartURL" => "Company Shopping Cart URL",
		"CompanyReportsDirectoryURL" => "Company Reports Directory URL",
		"CompanySupportDirectoryURL" => "Company Support Directory URL",
		"CompanyWebCRMDirectoryURL" => "Company Web CRM Directory URL",
		"CompanyNotes" => "Company Notes",
		"CurrencyID" => "Currency ID",
		"BankAccount" => "Bank Account",
		"Terms" => "Terms",
		"FedTaxID" => "Fed Tax ID",
		"StateTaxID" => "State TaxI D",
		"VATRegistrationNumber" => "VAT Registration Number",
		"VATSalesTaxID" => "VAT SalesTax ID",
		"VATPurchaseTaxID" => "VAT Purchase Tax ID",
		"VATOtherRegistrationNumber" => "VAT Other RegistrationN umber",
		"DefaultGLPostingDate" => "Default GL Posting Date",
		"DefaultSalesGLTracking" => "Default Sales GL Tracking",
		"DefaultGLPurchaseGLTracking" => "Default GL Purchase GL Tracking",
		"DefaultSalesTaxGroup" => "Default Sales Tax Group",
		"DefaultPurchaseTaxGroup" => "Default Purchase Tax Group",
		"DefaultInventoryCostingMethod" => "Default Inventory Costing Method",
		"AgeInvoicesBy" => "Age Invoices By",
		"AgePurchaseOrdersBy" => "Age Purchase Orders By",
		"FinanceCharge" => "Finance Charge",
		"FinanceChargePercent" => "Finance Charge Percent",
		"WarehouseID" => "Warehouse ID",
		"WarehouseBinID" => "Warehouse Bin ID",
		"ShippingMethod" => "Shipping Method",
		"ChargeHandling" => "Charge Handling",
		"HandlingAsPercent" => "Handling As Percent",
		"HandlingRate" => "Handling Rate",
		"ChargeMinimumSurcharge" => "Charge Minimum Surcharge",
		"MinimumSurchargeThreshold" => "Minimum Surcharge Threshold",
		"GLAPAccount" => "GL AP Account",
		"GLAPCashAccount" => "GL AP Cash Account",
		"GLAPInventoryAccount" => "GL AP Inventory Account",
		"GLAPFreightAccount" => "GL AP Freight Account",
		"GLAPHandlingAccount" => "GL AP Handling Account",
		"GLAPMiscAccount" => "GL AP Misc Account",
		"GLAPDiscountAccount" => "GL AP Discount Account",
		"GLAPPrePaidAccount" => "GL AP Pre Paid Account",
		"GLAPWriteOffAccount" => "GL AP Write Off Account",
		"GLARAccount" => "GL AR Account",
		"GLARCashAccount" => "GL AR Cash Account",
		"GLARSalesAccount" => "GL AR Sales Account",
		"GLARCOGSAccount" => "GL AR COGS Account",
		"GLARInventoryAccount" => "GL AR Inventory Account",
		"GLARFreightAccount" => "GL AR Freight Account",
		"GLARHandlingAccount" => "GL AR Handling Account",
		"GLARDiscountAccount" => "GL AR Discount Account",
		"GLARMiscAccount" => "GL AR Misc Account",
		"GLARReturnAccount" => "GL AR Return Account",
		"GLARWriteOffAccount" => "GL AR Write Off Account",
		"GLFixedAccumDepreciationAccount" => "GL Fixed Accum Depreciation Account",
		"GLFixedDepreciationAccount" => "GL Fixed Depreciation Account",
		"GLFixedAssetAccount" => "GL Fixed Asset Account",
		"GLFixedDisposalAccount" => "GL Fixed Disposal Account",
		"GLBankInterestEarnedAccount" => "GL Bank Interest Earned Account",
		"GLBankServiceChargesAccount" => "GL Bank Service Charges Account",
		"GLBankMiscWithdrawlAccount" => "GL Bank Misc Withdrawl Account",
		"GLBankBankMisDepositAccount" => "GL Bank Bank Mis Deposit Account",
		"GLBankOtherChargesAccount" => "GL Bank Other Charges Account",
		"GLRetainedEarningsAccount" => "GL Retained Earnings Account",
		"GLProfitLossAccount" => "GL Profit Loss Account",
		"GLUnrealizedCurrencyProfitLossAccount" => "GL Unrealized Currency Profit Loss Account",
		"GLRealizedCurrencyProfitLossAccount" => "GL Realized CurrencyP rofit Loss Account",
		"GLARFreightProfitLossAccount" => "GLAR Freight Profit Loss Account",
		"GLCurrencyGainLossAccount" => "GL Currency Gain Loss Account",
		"GLUnrealizedCurrencyGainLossAccount" => "GL Unrealize dCurrency Gain Los sAccount",
		"FiscalStartDate" => "Fiscal Start Date",
		"FiscalEndDate" => "Fiscal End Date",
		"CurrentFiscalYear" => "Current Fiscal Year",
		"CurrentPeriod" => "Current Period",
		"Period1Date" => "Period 1 Date",
		"Period2Date" => "Period 2 Date",
		"Period3Date" => "Period 3 Date",
		"Period4Date" => "Period 4 Date",
		"Period5Date" => "Period 5 Date",
		"Period6Date" => "Period 6 Date",
		"Period7Date" => "Period 7 Date",
		"Period8Date" => "Period 8 Date",
		"Period9Date" => "Period 9 Date",
		"Period10Date" => "Period 10 Date",
		"Period11Date" => "Period 11 Date",
		"Period12Date" => "Period 12 Date",
		"Period13Date" => "Period 13 Date",
		"Period14Date" => "Period 14 Date",
		"Period1Closed" => "Period 1 Closed",
		"Period2Closed" => "Period 2 Closed",
		"Period3Closed" => "Period 3 Closed",
		"Period4Closed" => "Period 4 Closed",
		"Period5Closed" => "Period 5 Closed",
		"Period6Closed" => "Period 6 Closed",
		"Period7Closed" => "Period 7 Closed",
		"Period8Closed" => "Period 8 Closed",
		"Period9Closed" => "Period 9 Closed",
		"Period10Closed" => "Period 10 Closed",
		"Period11Closed" => "Period 11 Closed",
		"Period12Closed" => "Period 12 Closed",
		"Period13Closed" => "Period 13 Closed",
		"Period14Closed" => "Period 14 Closed",
		"GAAPCompliant" => "GAAP Compliant",
		"EditGLTranssactions" => "Edit GL Transsactions",
		"EditBankTransactions" => "Edit Bank Transactions",
		"EditAPTransactions" => "Edit AP Transactions",
		"EditARTransactions" => "Edit AR Transactions",
		"HardClose" => "Hard Close",
		"AuditTrail" => "Audit Trail",
		"PeriodPosting" => "Period Posting",
		"SystemDates" => "System Dates"
	];

    public function CreateCompany(){
        $user = Session::get("user");
        
        $CompanyID = $_POST["CompanyID"];
        $pdo = DB::connection()->getPdo();
        $result = DB::select("select * FROM Companies WHERE CompanyID='$CompanyID'", array());
        if(count($result))
            return response("Company Already Exists", 400)->header('Content-Type', 'text/plain');
                
        $result = DB::select("show tables", array());
        foreach($result as $key=>$row){
            if($row->Tables_in_myenterprise != "activeemployee" &&
               $row->Tables_in_myenterprise != "audittrail" &&
               $row->Tables_in_myenterprise != "translation" &&
               $row->Tables_in_myenterprise != "translations" &&
               $row->Tables_in_myenterprise != "dtproperties" &&
               $row->Tables_in_myenterprise != "gl detail by date" &&
               $row->Tables_in_myenterprise != "gl details" &&
               !preg_match("/history$/", $row->Tables_in_myenterprise) &&
               !preg_match("/^audit/", $row->Tables_in_myenterprise) &&
               !preg_match("/^report/", $row->Tables_in_myenterprise) &&
               !preg_match("/report$/", $row->Tables_in_myenterprise))
            $tables[] = $row->Tables_in_myenterprise;
        }

        foreach($tables as $tableName){
            $desc = DB::select("describe $tableName", array());
            $keys = 0;
            foreach($desc as $column)
                if($column->Field == "CompanyID" || $column->Field == "DivisionID" || $column->Field == "DepartmentID")
                    $keys++;
            if($keys == 3)
                $tablesColumns[$tableName] = $desc;
            // else
            //  return response("Wrong table $tableName in database", 400)->header('Content-Type', 'text/plain');
        }

        $response = "";
        foreach($tablesColumns as $tableName=>$desc){
            $data = DB::select("select * from $tableName WHERE CompanyID='{$user["CompanyID"]}'", array());
            if(count($data) && property_exists($data[0], "CompanyID") && property_exists($data[0], "DivisionID") && property_exists($data[0], "DepartmentID")){
                $columns = [];
                foreach($data[0] as $key=>$column)
                    $columns[] = $key;
                if($tableName != "ledgerstoredchartofaccounts"){
                    $query = "INSERT INTO $tableName (" . implode(",", $columns) . ") VALUES";
                    foreach($data as $row){
                        $query .= "(";
                        foreach($row as $key=>$value){
                            if($key == "CompanyID")
                                $value = $CompanyID;

                            if($value == "" &&
                               $key != "CustomerID"&&
                               $key != "CustomerItemID"&&
                               $key != "ContactID"&&
                               $key != "ContactLogID"&&
                               $key != "InvoiceNumber"&&
                               $key != "OrderNumber"&&
                               $key != "EmployeeID"&&
                               $key != "PurchaseNumber")
                                $query .= "NULL,";
                            else
                                $query .= $pdo->quote($value) . ",";
                        }
                        $query = substr($query, 0, -1);
                        $query .= "),";
                    }
                    $query = substr($query, 0, -1);
                    try {
                        DB::insert($query, array());
                    } catch (\Illuminate\Database\QueryException $ex) {
                        echo 'Выброшено исключение: ',  $ex->getMessage(), "\n";
                    } //              $response .= $query;
                }else{
                    foreach($data as $row){
                        $query = "INSERT INTO $tableName (" . implode(",", $columns) . ") VALUES";
                        $query .= "(";
                        foreach($row as $key=>$value){
                            if($key == "CompanyID")
                                $value = $CompanyID;

                            if($value == "" &&
                               $key != "CustomerID"&&
                               $key != "CustomerItemID"&&
                               $key != "ContactID"&&
                               $key != "ContactLogID"&&
                               $key != "InvoiceNumber"&&
                               $key != "OrderNumber"&&
                               $key != "EmployeeID"&&
                               $key != "PurchaseNumber")
                                $query .= "NULL,";
                            else
                                $query .= $pdo->quote($value) . ",";
                        }
                        $query = substr($query, 0, -1);
                        $query .= ")";
                        try {
                            DB::insert($query, array());
                        } catch (\Illuminate\Database\QueryException $ex) {
                            echo 'Выброшено исключение: ',  $ex->getMessage(), "\n";
                        } //              $response .= $query;
                    }
                }
            }
        }

        echo "ok";
    }
}
?>
