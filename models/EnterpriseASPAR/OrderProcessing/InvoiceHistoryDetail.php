<?php
/*
  Name of Page: Invoice History Detail model

  Method: Model for Invoice Detail form. It provides data from database and default values, column names and categories

  Date created: 05/18/2017 Zaharov Nikita

  Use: this model used by views/InvoiceDetail for
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by grid controllers
  used as model by views

  Calls:
  MySql Database

  Last Modified: 05/19/2017
  Last Modified by: Zaharov Nikita
*/
require "./models/gridDataSource.php";

class gridData extends gridDataSource{
	protected $tableName = "invoicedetailhistory";
    //	protected $gridConditions = "(LOWER(IFNULL(OrderHeader.TransactionTypeID, N'')) NOT IN ('return', 'service order', 'quote')) AND (LOWER(IFNULL(OrderHeader.OrderTypeID, N'')) <> 'hold') AND (IFNULL(Picked, 0) = 0) AND (IFNULL(Shipped, 0) = 0) AND (IFNULL(Backordered, 0) = 0) AND (IFNULL(Invoiced, 0) = 0)";	
	public $dashboardTitle ="Invoice Detail";
	public $breadCrumbTitle ="Invoice Detail";
	public $idField ="InvoiceNumber";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","InvoiceNumber", "InvoiceLineNumber"];
	public $gridFields = [
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
            "inputType" => "dropdown",
            "defaultValue" => "USD",
            "dataProvider" => "getCurrencyTypes"
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

	public $editCategories = [
		"Main" => [
            "InvoiceNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => ""
            ],
            "InvoiceLineNumber" => [
                "dbType" => "bigint(20)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "autogenerated" => true,
                "defaultValue" => "-1"
            ],
            "ItemID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Description" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SerialNumber" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
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
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "OrderQty" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Backordered" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
            "BackorderQty" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => "0"
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
            "TotalWeight" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemCost" =>	[
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "DiscountPerc" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemUnitPrice" =>	[
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "Taxable" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
            "TaxGroupID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getTaxGroups",
                "defaultValue" => ""
            ],
            "TaxPercent" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TaxAmount" =>	[
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "defaultValue" => "USD",
                "dataProvider" => "getCurrencyTypes"
            ],
            "SubTotal" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "Total" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00"
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
			]
        ]
    ];

    public $columnNames = [
        "InvoiceNumber" => "Invoice",
        "OrderNumber" => "Order",
        "InvoiceLineNumber" => "Line Number",
        "ItemID" => "Item ID",
        "Description" => "Description",
        "SerialNumber" => "Serial / Lot Number",
        "WarehouseID" => "Warehouse",
        "WarehouseBinID" => "Bin",
        "OrderQty" => "Order Qty",
        "Backordered" => "Back ordered",
        "BackorderQyyty" => "Back ordered Qyyty",
        "ItemUOM" => "UOM",
        "ItemWeight" => "Weight",
        "TotalWeight" => "Total Weight",
        "ItemCost" =>  "Item Cost",
        "DiscountPerc" => "Discount",
        "ItemUnitPrice" =>	"Item Unit Price",
        "Taxable" => "Taxable",
        "TaxGroupID" => "Tax Group",
        "TaxPercent" => "Percent",
        "TaxAmount" =>	"Amount",
        "CurrencyID" => "Currency ID",
        "SubTotal" => "Sub Total",
        "Total" => "Total",
        "GLSalesAccount" => "GL Sales Account",
        "ProjectID" => "Project ID",
        "TrackingNumber" => "Tracking Number",
        "DetailMemo1" => "Memo 1",
        "DetailMemo2" => "Memo 2",
        "DetailMemo3" => "Memo 3",
        "DetailMemo4" => "Memo 4",
        "DetailMemo5" => "Memo 5"
    ];

    public $inventoryitemsIdFields = ["CompanyID","DivisionID","DepartmentID","ItemID"];
    public function getItems(){
        $user = $_SESSION["user"];
        $keyFields = "";
        $fields = [];

        foreach($this->inventoryitemsIdFields as $key){
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

        $result = $GLOBALS["DB"]::select("SELECT * from inventoryitems " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
}
?>
