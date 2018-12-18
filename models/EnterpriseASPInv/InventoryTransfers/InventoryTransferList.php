<?php
/*
  Name of Page: InventoryTransferList model

  Method: Model for gridView. It provides data from database and default values, column names and categories

  Date created: 06/05/2017 Nikita Zaharov

  Use: this model used by views/InventoryAdjustmentsList for:
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
  used as model by gridView

  Calls:
  MySql Database

  Last Modified: 12/18/2018
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    public $tableName = "inventorybywarehouse";
    public $dashboardTitle ="Transfer Inventory";
    public $breadCrumbTitle ="Transfer Inventory";
    public $idField ="ItemID";
    public $modes = ["grid", "view", "delete"];
    public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID", "WarehouseID", "WarehouseBinID"];
    public $gridFields = [
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
        "WarehouseBinID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "QtyOnHand" => [
            "dbType" => "int(11)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "QtyCommitted" => [
            "dbType" => "int(11)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "QtyOnOrder" => [
            "dbType" => "int(11)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "QtyOnBackorder" => [
            "dbType" => "int(11)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
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
            "WarehouseBinID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "QtyOnHand" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "QtyCommitted" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "QtyOnOrder" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "QtyOnBackorder" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CycleCode" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LastCountDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "TransferWarehouseID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getWarehouses",
                "fake" => "true",
                "alwaysEdit" => "true",
                "required" => false,
                "defaultValue" => ""
            ],
            "TransferWarehouseBinID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "depends" => [
                    "WarehouseID" => "TransferWarehouseID"
                ],
                "dataProvider" => "getWarehouseBins",
                "fake" => "true",
                "alwaysEdit" => "true",
                "required" => false,
                "defaultValue" => ""
            ],
            "TransferQty" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "fake" => "true",
                "alwaysEdit" => "true",
                "required" => false,
                "overrideDefault" => "true",
                "defaultValue" => 0
            ]
        ]
    ];

    public $columnNames = [
        "ItemID" => "Item ID",
        "WarehouseID" => "Warehouse ID",
        "WarehouseBinID" => "Warehouse Bin ID",
        "QtyOnHand" => "Qty On Hand",
        "QtyCommitted" => "Qty Committed",
        "QtyOnOrder" => "Qty On Order",
        "QtyOnBackorder" => "Qty On Backorder",
        "CycleCode" => "Cycle Code",
        "LastCountDate" => "Last Count Date",
        "TransferWarehouseID" => "Transfer Warehouse To",
        "TransferWarehouseBinID" => "Transfer Warehouse Bin To",
        "TransferQty" => "Transfer Qty"
    ];

    public function Inventory_Transfer(){
        $user = Session::get("user");

        DB::statement("CALL Inventory_Transfer('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["ItemID"] . "','" . $_POST["WarehouseID"] . "','" . $_POST["WarehouseBinID"] . "','" . $_POST["TransferWarehouseID"] . "','" . $_POST["TransferWarehouseBinID"] . "'," . $_POST["TransferQty"] . ", @SWP_RET_VALUE)");

        $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
        if($result[0]->SWP_RET_VALUE > -1)
            echo $result[0]->SWP_RET_VALUE;
        else{
            http_response_code(400);
            echo $result[0]->SWP_RET_VALUE;
        }
    }
}
?>
