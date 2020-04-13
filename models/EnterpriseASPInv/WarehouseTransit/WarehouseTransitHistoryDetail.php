<?php
/*
  Name of Page: Warehouse Transit Detail model
   
  Method: Model for gridView. It provides data from database and default values, column names and categories
   
  Date created: 22/05/2019 Nikita Zaharov
   
  Use: this model used by views/WarehouseTransitDetail for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by grid controller
  used as model by views/gridView
   
  Calls:
  MySql Database
   
  Last Modified: 22/05/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "warehousetransitdetailhistory";
    public $dashboardTitle ="Warehouse Transit Detail";
    public $breadCrumbTitle ="Warehouse Transit Detail";
    public $idField ="TransitID";
    public $idFields = ["CompanyID", "DivisionID", "DepartmentID", "TransitID"];
    public $modes = ["view"];
    public $gridFields = [
        "TransitDetailLineID" => [
            "dbType" => "int(11)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TransitItemID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TransitItemQuantity" => [
            "dbType" => "float",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TransitSourceWarehouse" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TransitSourceWarehouseBin" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TransitDestinationWarehouse" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TransitDestinationWarehouseBin" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TransitReceived" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "TransitTrackingNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "TransitID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => ""
            ],
            "TransitDetailLineID" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "disabledEdit" => true,
                "disabledNew" => true,
                "autogenerated" => true,
                "defaultOverride" => true,
                "defaultValue" => "(new)"
            ],
            "TransitItemID" => [
                "dbType" => "varchar(36)",                
                "inputType" => "dialogChooser",
                "dataProvider" => "getItems",
                "defaultValue" => ""
            ],
            "TransitItemQuantity" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitSourceWarehouse" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getWarehouses",
                "defaultValue" => ""
            ],
            "TransitSourceWarehouseBin" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "depends" => [
                    "WarehouseID" => "TransitSourceWarehouse"
                ],
                "dataProvider" => "getWarehouseBins",
                "defaultValue" => ""
            ],
            "TransitInTransitWarehouse" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getWarehouses",
                "defaultValue" => ""
            ],
            "TransitInTransitWarehouseBin" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "depends" => [
                    "WarehouseID" => "TransitInTransitWarehouse"
                ],
                "dataProvider" => "getWarehouseBins",
                "defaultValue" => ""
            ],
            "TransitDestinationWarehouse" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getWarehouses",
                "defaultValue" => ""
            ],
            "TransitDestinationWarehouseBin" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "depends" => [
                    "WarehouseID" => "TransitDestinationWarehouse"
                ],
                "dataProvider" => "getWarehouseBins",
                "defaultValue" => ""
            ],
            "TransitInstructions" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitReceived" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "TransitReceivedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "TransitRequestedBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitTrackingNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Memos" => [
            "TransitDetailMemo1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitDetailMemo2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitDetailMemo3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitDetailMemo4" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitDetailMemo5" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitDetailMemo6" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitDetailMemo7" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitDetailMemo8" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitDetailMemo9" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitDetailMemo10" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "TransitID" => "Transit ID",
        "TransitDetailLineID" => "Detail Line ID",
        "TransitItemID" => "Item ID",
        "TransitItemQuantity" => "Item Quantity",
        "TransitSourceWarehouse" => "Source Warehouse",
        "TransitSourceWarehouseBin" => "Source Warehouse Bin",
        "TransitInTransitWarehouse" => "In Transit Warehouse",
        "TransitInTransitWarehouseBin" => "In Transit Warehouse Bin",
        "TransitDestinationWarehouse" => "Destination Warehouse",
        "TransitDestinationWarehouseBin" => "Destination Warehouse Bin",
        "TransitInstructions" => "Instructions",
        "TransitReceived" => "Received",
        "TransitReceivedDate" => "Received Date",
        "TransitRequestedBy" => "Requested By",
        "TransitTrackingNumber" => "Tracking #",
        "TransitDetailMemo1" => "Memo 1",
        "TransitDetailMemo2" => "Memo 2",
        "TransitDetailMemo3" => "Memo 3",
        "TransitDetailMemo4" => "Memo 4",
        "TransitDetailMemo5" => "Memo 5",
        "TransitDetailMemo6" => "Memo 6",
        "TransitDetailMemo7" => "Memo 7",
        "TransitDetailMemo8" => "Memo 8",
        "TransitDetailMemo9" => "Memo 9",
        "TransitDetailMemo10" => "Memo 10"
    ];
}
?>
