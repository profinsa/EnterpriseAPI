<?php
/*
  Name of Page: InventoryItemsList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryItemsList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Nikita Zaharov
   
  Use: this model used by views/InventoryItemsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryItemsList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryItemsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 13/03/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
	public $tableName = "inventoryitems";
	public $dashboardTitle ="Inventory Items";
	public $breadCrumbTitle ="Inventory Items";
	public $idField ="ItemID";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID"];
	public $gridFields = [
		"ItemID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"IsActive" => [
			"dbType" => "tinyint(1)",
			"inputType" => "text"
		],
		"ItemTypeID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"ItemName" => [
			"dbType" => "varchar(50)",
			"inputType" => "text"
		],
		"ItemDescription" => [
			"dbType" => "varchar(80)",
			"inputType" => "text"
		],
		"ItemUPCCode" => [
			"dbType" => "varchar(12)",
			"inputType" => "text"
		],
		"Price" => [
			"dbType" => "decimal(19,4)",
			"format" => "{0:n}",
			"inputType" => "text"
		]
	];

	public $editCategories = [
		"Main" => [
			"ItemID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"IsActive" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"ItemTypeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CartItem" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
                "defaultOverride" => true,
				"defaultValue" => "1"
			],
			"ItemName" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemDescription" => [
				"dbType" => "varchar(80)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemLongDescription" => [
				"dbType" => "varchar(255)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemCategoryID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemFamilyID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"SalesDescription" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"PurchaseDescription" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"PictureURL" => [
				"dbType" => "varchar(80)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"Picture" => [
				"dbType" => "varchar(80)",
				"inputType" => "imageFile",
				"defaultValue" => ""
			],
			"LargePictureURL" => [
				"dbType" => "varchar(80)",
				"inputType" => "text",
				"defaultValue" => ""
			],
            "DownloadLocation" => [
				"dbType" => "varchar(120)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"DownloadPassword" => [
				"dbType" => "varchar(20)",
				"inputType" => "text",
				"defaultValue" => ""
			]
		],
		"Item Details" => [
			"ItemWeight" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemWeightMetric" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemShipWeight" => [
				"dbType" => "int(11)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemUPCCode" => [
				"dbType" => "varchar(12)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemEPCCode" => [
				"dbType" => "varchar(12)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemRFID" => [
				"dbType" => "varchar(80)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemSize" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemSizeCmm" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemDimentions" => [
				"dbType" => "varchar(10)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemDimentionsCmm" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemColor" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemNRFColor" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemStyle" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemNRFStyle" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemCareInstructions" => [
				"dbType" => "varchar(80)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemDefaultWarehouse" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemDefaultWarehouseBin" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemLocationX" => [
				"dbType" => "varchar(10)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemLocationY" => [
				"dbType" => "varchar(10)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemLocationZ" => [
				"dbType" => "varchar(10)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ItemUOM" => [
				"dbType" => "varchar(15)",
				"inputType" => "text",
				"defaultValue" => ""
			],
				"LeadTime" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"LeadTimeUnit" => [
				"dbType" => "varchar(10)",
				"inputType" => "text",
				"defaultValue" => ""
			]
		],
		"Cost" => [
			"GLItemSalesAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"GLItemCOGSAccount" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"GLItemInventoryAccount" => [
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
			"PricingMethods" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"Taxable" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"VendorID" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ReOrderLevel" => [
				"dbType" => "int(11)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ReOrderQty" => [
				"dbType" => "int(11)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"BuildTime" => [
				"dbType" => "int(11)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"BuildTimeUnit" => [
				"dbType" => "varchar(10)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"UseageRate" => [
				"dbType" => "int(11)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"UseageRateUnit" => [
				"dbType" => "varchar(10)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"SalesForecast" => [
				"dbType" => "int(11)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"SalesForecastUnit" => [
				"dbType" => "varchar(10)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CalculatedCover" => [
				"dbType" => "int(11)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CalculatedCoverUnits" => [
				"dbType" => "varchar(10)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"IsAssembly" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"ItemAssembly" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"LIFO" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"LIFOValue" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"LIFOCost" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"Average" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"AverageValue" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"AverageCost" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"FIFO" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"FIFOValue" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"FIFOCost" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"Expected" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ExpectedValue" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ExpectedCost" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"Landed" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"LandedValue" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"LandedCost" => [
				"dbType" => "char(10)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"Other" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"OtherValue" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"OtherCost" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"Commissionable" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"CommissionType" => [
				"dbType" => "smallint(6)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CommissionPerc" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
			],
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
			"TaxGroupID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"TaxPercent" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
			]
		],
        "Pricing Code" => [
            "loadFrom" => [
                "method" => "getPricingCode",
                "key" => "ItemID"
            ],
            "ItemID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text"
            ],
			"ItemPricingCode" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"Price" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"MSRP" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"SalesPrice" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"SaleStartDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => ""
			],
			"SaleEndDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => ""
			],
        ],
        "VAT Maintenance" => [
			"VATItem" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
            "VATItemType" => [
                "dbType" => "nvarchar(36)",
                "inputType" => "text"
            ],
			"VATExcluded" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"VATInvestibleItem" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"VATCreditingRight" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"VATSupply" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			]
        ],
        "Inventory Assemblies" => [
            "ItemID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text"
            ]
        ],
        "Item Transactions" => [
            "ItemID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text"
            ]
        ],
        "Item Transactions History" => [
            "ItemID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text"
            ]
        ]
    ];
    
	public $columnNames = [
		"ItemID" => "Item ID",
		"IsActive" => "Is Active",
		"ItemTypeID" => "Item Type ID",
		"ItemName" => "Item Name",
		"ItemDescription" => "Item Description",
		"ItemUPCCode" => "Item UPC Code",
		"Price" => "Price",
		"ItemLongDescription" => "Item Long Description",
		"ItemCategoryID" => "Item Category ID",
		"ItemFamilyID" => "Item Family ID",
		"SalesDescription" => "Sales Description",
		"PurchaseDescription" => "Purchase Description",
		"PictureURL" => "Picture URL",
		"Picture" => "Picture",
		"LargePictureURL" => "Large Picture URL",
		"ItemWeight" => "Item Weight",
		"ItemWeightMetric" => "Item Weight Metric",
		"ItemShipWeight" => "Item Ship Weight",
		"ItemEPCCode" => "Item EPC Code",
		"ItemRFID" => "Item RFID",
		"ItemSize" => "Item Size",
		"ItemSizeCmm" => "Item Size Cmm",
		"ItemDimentions" => "Item Dimentions",
		"ItemDimentionsCmm" => "Item Dimentions Cmm",
		"ItemColor" => "Item Color",
		"ItemNRFColor" => "Item NRF Color",
		"ItemStyle" => "Item Style",
		"ItemNRFStyle" => "Item NRF Style",
		"ItemCareInstructions" => "Item Care Instructions",
		"ItemDefaultWarehouse" => "Item Default Warehouse",
		"ItemDefaultWarehouseBin" => "Item Default Warehouse Bin",
		"ItemLocationX" => "Item Location X",
		"ItemLocationY" => "Item Location Y",
		"ItemLocationZ" => "Item Location Z",
		"DownloadLocation" => "Download Location",
		"DownloadPassword" => "Download Password",
		"ItemUOM" => "Item UOM",
		"GLItemSalesAccount" => "GL Item Sales Account",
		"GLItemCOGSAccount" => "GL Item COGS Account",
		"GLItemInventoryAccount" => "GL Item Inventory Account",
		"CurrencyID" => "Currency ID",
		"CurrencyExchangeRate" => "Currency Exchange Rate",
		"ItemPricingCode" => "Item Pricing Code",
		"PricingMethods" => "Pricing Methods",
		"Taxable" => "Taxable",
		"VendorID" => "Vendor ID",
		"LeadTime" => "Lead Time",
		"LeadTimeUnit" => "Lead Time Unit",
		"ReOrderLevel" => "Re Order Level",
		"ReOrderQty" => "Re Order Qty",
		"BuildTime" => "Build Time",
		"BuildTimeUnit" => "Build Time Unit",
		"UseageRate" => "Useage Rate",
		"UseageRateUnit" => "Useage Rate Unit",
		"SalesForecast" => "Sales Forecast",
		"SalesForecastUnit" => "Sales Forecast Unit",
		"CalculatedCover" => "Calculated Cover",
		"CalculatedCoverUnits" => "Calculated Cover Units",
		"IsAssembly" => "Is Assembly",
		"ItemAssembly" => "Item Assembly",
		"LIFO" => "LIFO",
		"LIFOValue" => "LIFO Value",
		"LIFOCost" => "LIFO Cost",
		"Average" => "Average",
		"AverageValue" => "Average Value",
		"AverageCost" => "Average Cost",
		"FIFO" => "FIFO",
		"FIFOValue" => "FIFO Value",
		"FIFOCost" => "FIFO Cost",
		"Expected" => "Expected",
		"ExpectedValue" => "Expected Value",
		"ExpectedCost" => "Expected Cost",
		"Landed" => "Landed",
		"LandedValue" => "Landed Value",
		"LandedCost" => "Landed Cost",
		"Other" => "Other",
		"OtherValue" => "Other Value",
		"OtherCost" => "Other Cost",
		"Commissionable" => "Commissionable",
		"CommissionType" => "Commission Type",
		"CommissionPerc" => "Commission Perc",
		"Approved" => "Approved",
		"ApprovedBy" => "Approved By",
		"ApprovedDate" => "Approved Date",
		"EnteredBy" => "Entered By",
		"TaxGroupID" => "Tax Group ID",
		"TaxPercent" => "Tax Percent",
        "TransactionType" => "Transaction Type",
		"TransactionNumber" => "Transaction Number",
		"TransactionDate" => "Transaction Date",
		"TransactionAmount" => "Transaction Amount",
        "CurrencyID" => "Currency ID",
		"ShipDate" => "Ship Date",
		"TrackingNumber" => "Tracking Number",
        "CVID" => "CVID",
        "ItemCost" => "Item Cost",
        "ItemUnitPrice" => "Item Unit Price",
        "VATItem" => "VAT Item",
        "VATItemType" => "VAT Item Type",
        "VATExcluded" => "VAT Excluded",
        "VATInvestibleItem" => "VAT Investible Item",
        "VATCreditingRight" => "VAT Crediting Right",
        "VATSupply" => "VAT Supply",
        "CartItem" => "Cart Item"
	];

    public function getPricingCode($id){
        $user = Session::get("user");
        //        $result = DB::select("SELECT ItemPricingCode from inventoryitems WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ItemID=?", array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $id));
        $pricingCodeResult = DB::select("SELECT ItemID, ItemPricingCode, Price, MSRP, SalesPrice, SaleStartDate, SaleEndDate from inventorypricingcode WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ItemID=?", array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $id));

        //echo "LALALAL" . json_encode($pricingCodeResult, JSON_PRETTY_PRINT) . $id;
        //return [];
        if(count($pricingCodeResult))
            return json_decode(json_encode($pricingCodeResult), true)[0];
        else
            return [
                "ItemID" => $id,
                "ItemPricingCode" => "",
                "Price" => "0.00",
                "MSRP" => "0.00",
                "SalesPrice" => "0.00",
                "SaleStartDate" => "",
                "SaleEndDate" => ""
            ];
    }
    
    public $detailPages = [
        "Item Transactions" => [
            "hideFields" => "true",
            "disableNew" => "true",
            "deleteDisabled" => "true",
            "editDisabled" => "true",
            "viewPath" => "AccountsReceivable/OrderProcessing/OrderTrackingDetail",
            "newKeyField" => "ItemID",
            "keyFields" => ["ItemID"],
            "detailIdFields" => ["CompanyID","DivisionID","DepartmentID","ItemID"],
            "gridFields" => [
                "TransactionType" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text"
                ],
                "TransactionNumber" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text"
                ],
                "TransactionDate" => [
                    "dbType" => "datetime",
                    "inputType" => "datetime"
                ],
                "TransactionAmount" => [
                    "dbType" => "decimal(19,4)",
                    "format" => "{0:n}",
                    "inputType" => "text"
                ],
                "CurrencyID" =>	[
                    "dbType" => "varchar(3)",
                    "inputType" => "dropdown",
                ],
                "CVID" => [
                    "dbType" => "varchar(50)",
                    "inputType" => "text"
                ],
                "ItemCost" => [
                    "dbType" => "decimal(19,4)",
                    "format" => "{0:n}",
                    "inputType" => "text"
                ],
                "ItemUnitPrice" => [
                    "dbType" => "decimal(19,4)",
                    "format" => "{0:n}",
                    "inputType" => "text"
                ]
            ]
        ],
        "Item Transactions History" => [
            "hideFields" => "true",
            "disableNew" => "true",
            "deleteDisabled" => "true",
            "editDisabled" => "true",
            "viewPath" => "AccountsReceivable/ProjectsJobs/ViewProjects",
            "newKeyField" => "ItemID",
            "keyFields" => ["ItemID"],
            "detailIdFields" => ["CompanyID","DivisionID","DepartmentID","ItemID"],
            "gridFields" => [
                "TransactionType" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text"
                ],
                "TransactionNumber" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text"
                ],
                "TransactionDate" => [
                    "dbType" => "datetime",
                    "inputType" => "datetime"
                ],
                "TransactionAmount" => [
                    "dbType" => "decimal(19,4)",
                    "format" => "{0:n}",
                    "inputType" => "text"
                ],
                "CurrencyID" =>	[
                    "dbType" => "varchar(3)",
                    "inputType" => "dropdown",
                ],
                "CVID" => [
                    "dbType" => "varchar(50)",
                    "inputType" => "text"
                ],
                "ItemCost" => [
                    "dbType" => "decimal(19,4)",
                    "format" => "{0:n}",
                    "inputType" => "text"
                ],
                "ItemUnitPrice" => [
                    "dbType" => "decimal(19,4)",
                    "format" => "{0:n}",
                    "inputType" => "text"
                ]
            ]
        ]
    ];

    //getting rows for grid
    public function getTransactionsWithType($ItemID, $type){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->detailPages["Item Transactions"]["gridFields"] as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailPages["Item Transactions"]["detailIdFields"] as $key){
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

        $keyFields .= " AND ItemID='" . $ItemID . "'";

        
        $result = $GLOBALS["capsule"]::select("SELECT " . implode(",", $fields) . " from " . ($type == "history" ? "itemhistorytransactions " : "itemtransactions " ) .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
    
    public function getItemTransactions($ID){
        return $this->getTransactionsWithType($ID, "normal");
    }
    
    public function getItemTransactionsHistory($ID){
        return $this->getTransactionsWithType($ID, "history");
    }
}
?>
