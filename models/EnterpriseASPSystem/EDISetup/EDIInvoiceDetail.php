<?php
/*
  Name of Page: EDI Invoice Detail

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

  Last Modified: 19/02/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
class EDIInvoiceDetail extends gridDataSource{
    public $tableName = "ediinvoicedetail";
    public $dashboardTitle = "EDI Invoice Detail";
    public $breadCrumbTitle = "EDI Invoice Detail";
	public $idField ="InvoiceNumber";
	public $idFields = ["CompanyID","DivisionID","DepartmentID", "InvoiceNumber", "InvoiceLineNumber"];
    public $gridFields = [
        "InvoiceNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "InvoiceLineNumber" => [
            "dbType" => "bigint(20)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ItemID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "WarehouseID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SerialNumber" => [
            "dbType" => "varchar(50)",
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
        "BackOrderQty" => [
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
        "Description" => [
            "dbType" => "varchar(80)",
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
            "inputType" => "text",
            "defaultValue" => ""
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
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ProjectID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TrackingNumber" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
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
            "inputType" => "text",
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
            "SerialNumber" => [
                "dbType" => "varchar(50)",
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
            "BackOrderQty" => [
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
            "Description" => [
                "dbType" => "varchar(80)",
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
        "InvoiceNumber" => "Invoice Number",
        "InvoiceLineNumber" => "Invoice Line Number",
        "ItemID" => "Item ID",
        "WarehouseID" => "Warehouse ID",
        "SerialNumber" => "Serial Number",
        "OrderQty" => "Order Qty",
        "BackOrdered" => "Back Ordered",
        "BackOrderQty" => "Back Order Qty",
        "ItemUOM" => "Item UOM",
        "ItemWeight" => "Item Weight",
        "Description" => "Description",
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
        "TrackingNumber" => "Tracking Number",
        "DetailMemo1" => "Memo1",
        "DetailMemo2" => "Memo2",
        "DetailMemo3" => "Memo3",
        "DetailMemo4" => "Memo4",
        "DetailMemo5" => "Memo5",
        "TaxGroupID" => "Tax Group ID",
        "TaxAmount" => "Tax Amount",
        "TaxPercent" => "Tax Percent",
        "SubTotal" => "Sub Total"
    ];
}
?>
