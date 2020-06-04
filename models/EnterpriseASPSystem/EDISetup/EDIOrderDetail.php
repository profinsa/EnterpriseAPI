<?php
/*
  Name of Page: EDI Order Detail

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

  Last Modified: 20/02/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/subgridDataSource.php";
class EDIOrderDetail extends subgridDataSource{
    public $tableName = "ediorderdetail";
    public $dashboardTitle ="EDI Order Detail";
    public $breadCrumbTitle ="EDI Order Detail";
	public $idField ="OrderNumber";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","OrderNumber", "OrderLineNumber"];
    public $gridFields = [
		"ItemID" => [
			"dbType" => "varchar(36)",
            "inputType" => "dialogChooser",
            "dataProvider" => "getItems",
            "defaultValue" => ""
		],
		"Description" => [
			"dbType" => "varchar(80)",
			"inputType" => "text"
		],
        "GLSalesAccount" => [
            "dbType" => "varchar(36)",
            "inputType" => "dropdown",
            "dataProvider" => "getAccounts",
            "defaultValue" => ""
        ],
        "ProjectID" => [
            "dbType" => "varchar(36)",
            "inputType" => "dropdown",
            "dataProvider" => "getProjects",
            "defaultValue" => ""
        ],
		"OrderQty" => [
			"dbType" => "float",
			"inputType" => "text"
		],
        /*		"ItemUOM" => [
            "dbType" => "varchar(15)",
            "inputType" => "text"
            ],*/
        "ItemUnitPrice" =>	[
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        /*		"CurrencyID" => [
			"dbType" => "varchar(3)",
            "inputType" => "dropdown",
            "defaultValue" => "USD",
            "dataProvider" => "getCurrencyTypes"
            ],*/
		"Total" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
		]
    ];

    public $editCategories = [
        "Main" => [
            "OrderNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => "0.00"
            ],
            "OrderLineNumber" => [
                "dbType" => "bigint(20)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "autogenerated" => true,
                "defaultValue" => "-1"
            ],
            "ItemID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dialogChooser",
                "dataProvider" => "getItems",
                "defaultValue" => ""
            ],
            "WarehouseID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getWarehouses",
                "defaultValue" => ""
            ],
            "WarehouseBinID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "depends" => [
                    "WarehouseID" => "WarehouseID"
                ],
                "dataProvider" => "getWarehouseBins",
                "defaultValue" => ""
            ],
            "SerialNumber" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Description" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "OrderQty" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BackOrdered" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "BackOrderQyyty" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemUOM" => [
                "dbType" => "varchar(15)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemWeight" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DiscountPerc" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Taxable" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "defaultValue" => "USD",
                "dataProvider" => "getCurrencyTypes"
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemCost" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemUnitPrice" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Total" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TotalWeight" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLSalesAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "ProjectID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getProjects",
                "defaultValue" => ""
            ],
            "WarehouseBinZone" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PalletLevel" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CartonLevel" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PackLevelA" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PackLevelB" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PackLevelC" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TrackingNumber" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Memos" => [
            "DetailMemo1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DetailMemo2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DetailMemo3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DetailMemo4" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DetailMemo5" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TaxGroupID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getTaxGroups",
                "defaultValue" => ""
            ],
            "TaxAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TaxPercent" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SubTotal" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "OrderNumber" => "Order Number",
        "OrderLineNumber" => "Order Line Number",
        "ItemID" => "Item ID",
        "WarehouseID" => "Warehouse ID",
        "WarehouseBinID" => "WarehouseBin ID",
        "SerialNumber" => "Serial Number",
        "Description" => "Description",
        "OrderQty" => "Order Qty",
        "BackOrdered" => "Back Ordered",
        "BackOrderQyyty" => "Back Order Qyyty",
        "ItemUOM" => "Item UOM",
        "ItemWeight" => "Item Weight",
        "DiscountPerc" => "Discount Perc",
        "Taxable" => "Taxable",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "ItemCost" => "Item Cost",
        "ItemUnitPrice" => "Item Unit Price",
        "Total" => "Total",
        "TotalWeight" => "Total Weight",
        "GLSalesAccount" => "GL Sales Account",
        "ProjectID" => "Project ID",
        "WarehouseBinZone" => "Warehouse Bin Zone",
        "PalletLevel" => "Pallet Level",
        "CartonLevel" => "Carton Level",
        "PackLevelA" => "PackLevel A",
        "PackLevelB" => "PackLevel B",
        "PackLevelC" => "PackLevel C",
        "TrackingNumber" => "Tracking #",
        "DetailMemo1" => "Memo1",
        "DetailMemo2" => "Memo2",
        "DetailMemo3" => "Memo3",
        "DetailMemo4" => "Memo4",
        "DetailMemo5" => "Memo5",
        "TaxGroupID" => "Tax Group ID",
        "TaxAmount" => "Tax Amount",
        "TaxPercent" => "Tax Percent",
        "SubTotal" => "SubTotal"
    ];
}
?>
