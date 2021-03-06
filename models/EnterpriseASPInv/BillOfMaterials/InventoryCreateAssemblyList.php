<?php
/*
  Name of Page: InventoryCreateAssemblyList model
   
  Method: Model for grid view It provides data from database and default values, column names and categories
   
  Date created: 25/03/2019
   
  Use: this model used by gridView
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
   
  Last Modified: 25/03/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class InventoryCreateAssemblyList extends gridDataSource{
    public $tableName = "inventoryassemblies";
    public $dashboardTitle ="Inventory Assemblies";
    public $breadCrumbTitle ="Inventory Assemblies";
    public $idField ="AssemblyID";
    public $modes = ["grid"];
    public $idFields = ["CompanyID","DivisionID","DepartmentID","AssemblyID"]; // "ItemID"
    public $gridFields = [
        "AssemblyID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "AssemblyID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => "true"
            ],
            "NumberOfItemsInAssembly" => [
                "dbType" => "smallint(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WarehouseID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getWarehouses"
            ],
            "WarehouseBinID" => [
                "dbType" => "varchar(36)",
                "depends" => [
                    "WarehouseID" => "WarehouseID"
                ],
                "dataProvider" => "getWarehouseBins",
                "inputType" => "dropdown",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "AssemblyID" => "Assembly ID",
        "ItemID" => "Item ID",
        "NumberOfItemsInAssembly" => "Assembly Quantity",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "LaborCost" => "Labor Cost",
        "WarehouseID" => "Warehouse ID",
        "WarehouseBinID" => "Warehouse Bin ID",
        "Approved" => "Approved",
        "ApprivedBy" => "Apprived By",
        "ApprovedDate" => "Approved Date",
        "EnteredBy" => "Entered By"
    ];

    
    public function getPage($customer){
        $user = Session::get("user");
        $query = <<<EOF
       SELECT DISTINCT CompanyID, DivisionID, DepartmentID, AssemblyID, '' AS WarehouseID, '' AS WarehouseBinID, 0 AS QtyRequired FROM InventoryAssemblies InventoryCreateAssembly WHERE CompanyID=? AND DivisionID = ? AND DepartmentID = ?
EOF;
        
        $result = DB::select($query, array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]));
        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function CreateAssembly(){
        $user = Session::get("user");

        DB::statement("set @qty =" . $_POST["QtyRequired"]);
        DB::statement("CALL Inventory_Assemblies('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["ItemID"]. "','" . $_POST["WarehouseID"] . "', @qty, @Result,@SWP_RET_VALUE)");

        $result = DB::select('select @Result as Result, @SWP_RET_VALUE as SWP_RET_VALUE');

        switch($result[0]->Result) {
            case 0:
                $error = "Assembly was not created: It is not enough existing items to create requested Assembly Quantity.";
                break;
            case 1:
                echo "ok";
                return;
            case 2:
                $error = "Assembly was not created: Assembly Quantity should be more then 0.";
                break;
            default:
                $error = "Assembly was not created: Error during assembly creatin occured";
                break;
        }

        http_response_code(400);
        echo $error;
    }
}
?>
