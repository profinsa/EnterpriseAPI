<?php
/*
  Name of Page: Inventory Adjustments Detail
   
  Method: Model for gridView. It provides data from database and default values, column names and categories
   
  Date created: 19/03/2019 Zaharov Nikita
   
  Use: this model used by views/gridView for:
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
  used as model by views/gridView
   
  Calls:
  MySql Database
   
  Last Modified: 28/03/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/subgridDataSource.php";
class gridData extends subgridDataSource{
    public $tableName = "inventoryadjustmentsdetail";
    public $dashboardTitle ="inventoryadjustmentsdetail";
    public $breadCrumbTitle ="inventoryadjustmentsdetail";
    public $idField ="";
    public $idFields = ["AdjustmentID", "AdjustmentLineID"];
    public $gridFields = [
        /*        "AdjustmentID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "AdjustmentLineID" => [
            "dbType" => "bigint(20)",
            "inputType" => "text",
            "defaultValue" => ""
            ],*/
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
        "OriginalQuantity" => [
            "dbType" => "float",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "AdjustedQuantity" => [
            "dbType" => "float",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "Cost" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "GLAdjustmentPostingAccount" => [
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
        ]
    ];

    public $editCategories = [
        "Main" => [
            "AdjustmentID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AdjustmentLineID" => [
                "dbType" => "bigint(20)",
                "inputType" => "text",
                "defaultValue" => ""
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
            "AdjustmentDescription" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "OriginalQuantity" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AdjustedQuantity" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Cost" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAdjustmentPostingAccount" => [
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
            ]
        ]
    ];
    
    public $columnNames = [
        "AdjustmentID" => "Adjustment ID",
        "AdjustmentLineID" => "Adjustment Line ID",
        "ItemID" => "Item ID",
        "WarehouseID" => "Warehouse ID",
        "WarehouseBinID" => "Bin ID",
        "AdjustmentDescription" => "Adjustment Description",
        "OriginalQuantity" => "Original Qty",
        "AdjustedQuantity" => "Adjusted Qty",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "Cost" => "Cost",
        "GLAdjustmentPostingAccount" => "GL Adjustment Posting Account",
        "ProjectID" => "Project ID",
        "GLControlNumber" => "GL Control Number"
    ];
}
?>
