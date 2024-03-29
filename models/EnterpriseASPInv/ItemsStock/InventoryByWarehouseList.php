<?php
/*
  Name of Page: InventoryByWarehouseList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryByWarehouseList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Nikita Zaharov
   
  Use: this model used by views/InventoryByWarehouseList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryByWarehouseList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryByWarehouseList.php
   
  Calls:
  MySql Database
   
  Last Modified: 26/09/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class InventoryByWarehouseList extends gridDataSource{
    public $tableName = "inventorybywarehouse";
    public $dashboardTitle ="Inventory By Warehouse";
    public $breadCrumbTitle ="Inventory By Warehouse";
    public $idField ="ItemID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","WarehouseID","WarehouseBinID"];
    public $gridFields = [
        "ItemID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "WarehouseID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "WarehouseBinID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "QtyOnHand" => [
            "dbType" => "int(11)",
            "inputType" => "text"
        ],
        "QtyCommitted" => [
            "dbType" => "int(11)",
            "inputType" => "text"
        ],
        "QtyAvailable" => [
            "fake" => true,
            "dbType" => "int(11)",
            "inputType" => "text"
        ],
        "QtyOnOrder" => [
            "dbType" => "int(11)",
            "inputType" => "text"
        ],
        "QtyOnBackorder" => [
            "dbType" => "int(11)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "ItemID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => true,
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
            ]
        ]
    ];
    public $columnNames = [
        "ItemID" => "Item ID",
        "WarehouseID" => "Warehouse ID",
        "WarehouseBinID" => "Warehouse Bin ID",
        "QtyOnHand" => "Qty On Hand",
        "QtyCommitted" => "Qty Committed",
        "QtyAvailable" => "Qty Available",
        "QtyOnOrder" => "Qty On Order",
        "QtyOnBackorder" => "Qty On Backorder",
        "CycleCode" => "Cycle Code",
        "LastCountDate" => "Last Count Date"
    ];

    public function getEditItem($id, $type){
        $user = Session::get("user");
        $result = parent::getEditItem($id, $type);
        
        $details = DB::select("select orderheader.CompanyID, orderheader.DivisionID, orderheader.DepartmentID, orderheader.OrderNumber, orderheader.OrderTypeID, orderheader.OrderDate, orderheader.CustomerID, orderheader.CurrencyID, orderheader.Total, orderheader.ShipDate, orderheader.TrackingNumber, orderheader.Invoiced, orderheader.InvoiceNumber, orderdetail.OrderQty from orderdetail inner join orderheader on orderdetail.OrderNumber=orderheader.OrderNumber AND orderdetail.CompanyID=orderheader.CompanyID AND orderdetail.DivisionID=orderheader.DivisionID AND orderdetail.DepartmentID=orderheader.DepartmentID where orderheader.CompanyID=? AND orderheader.DivisionID=? AND orderheader.DepartmentID=? AND orderdetail.ItemID=? AND orderheader.Shipped=0 AND orderheader.TransactionTypeID='Order'", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $result["ItemID"]]);
        
        $qtyCommitted = 0;
        foreach($details as $drow)
            $qtyCommitted += $drow->OrderQty;
        //echo json_encode($details);
        if($result["QtyCommitted"] < 0)
            $result["QtyCommitted"] = 0;
        //        $result["QtyCommitted"] = $qtyCommitted;
        return $result;
    }
    public function getPage($id){
        $user = Session::get("user");
        $result = parent::getPage($id);
        foreach($result as &$row){
            $details = DB::select("select orderheader.CompanyID, orderheader.DivisionID, orderheader.DepartmentID, orderheader.OrderNumber, orderdetail.OrderQty from orderdetail inner join orderheader on orderdetail.OrderNumber=orderheader.OrderNumber AND orderdetail.CompanyID=orderheader.CompanyID AND orderdetail.DivisionID=orderheader.DivisionID AND orderdetail.DepartmentID=orderheader.DepartmentID where orderheader.CompanyID=? AND orderheader.DivisionID=? AND orderheader.DepartmentID=? AND orderdetail.ItemID=? AND orderheader.Shipped=0 AND orderheader.TransactionTypeID='Order'", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $row["ItemID"]]);
            $qtyCommitted = 0;
            //foreach($details as $drow)
            //$qtyCommitted += $drow->OrderQty;
            if($row["QtyCommitted"] < 0)
                $row["QtyCommitted"] = 0;
            $row["QtyAvailable"] = $row["QtyOnHand"] - $row["QtyCommitted"];
            if($row["QtyAvailable"] < 0)
                $row["QtyAvailable"] = 0;
            //echo json_encode($detail);
            //$row["QtyCommitted"] = $qtyCommitted;
            //DB::UPDATE("update inventorybywarehouse set QtyCommitted='{$qtyCommitted}' WHERE CompanyID='{$user["CompanyID"]}' AND DivisionID='{$user["DivisionID"]}' AND DepartmentID='{$user["DepartmentID"]}' AND ItemID='{$row["ItemID"]}'");
        }
        return $result;
    }
}
?>
