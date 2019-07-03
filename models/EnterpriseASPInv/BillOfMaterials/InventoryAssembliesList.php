<?php
/*
  Name of Page: InventoryAssembliesList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\BillofMaterials\InventoryAssembliesList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Nikita Zaharov
   
  Use: this model used by views/InventoryAssembliesList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\BillofMaterials\InventoryAssembliesList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\BillofMaterials\InventoryAssembliesList.php
   
  Calls:
  MySql Database
   
  Last Modified: 05/30/2017
  Last Modified by: Nikita Zaharov
*/
require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    public $tableName = "inventoryassemblies";
    public $dashboardTitle ="Inventory Assemblies";
    public $breadCrumbTitle ="Inventory Assemblies";
    public $idField ="AssemblyID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","AssemblyID","ItemID"];
    public $gridFields = [
        "AssemblyID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ]
    ];

    public $makeTabs = true;
    
    public $editCategories = [
        "Main" => [
            "AssemblyID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Assembly Instructions" => [
            "AssemblyID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "...fields" => [
            "AssemblyID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemID" => [
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
            "NumberOfItemsInAssembly" => [
                "dbType" => "int(11)",
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
            "Approved" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApprivedBy" => [
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
            ]
        ]
    ];
    
    public $columnNames = [
        "AssemblyID" => "Assembly ID",
        "ItemID" => "Item ID",
        "NumberOfItemsInAssembly" => "Number Of Items In Assembly",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "LaborCost" => "Labor Cost",
        "WarehouseID" => "Warehouse ID",
        "WarehouseBinID" => "Warehouse Bin ID",
        "Approved" => "Approved",
        "ApprivedBy" => "Apprived By",
        "ApprovedDate" => "Approved Date",
        "EnteredBy" => "Entered By",
        "AssemblyBuildInstructions" => "Build Instructions",
        "AssemblySchematicURL" => "Schematic URL",
        "AssemblyPictureURL" => "Picture URL",
        "AssemblyDiagramURL" => "Diagram URL",
        "AssemblyOtherURL" => "Other URL",
        "AssemblyLastUpdated" => "Last Updated",
        "AssemblyLastUpdatedBy" => "Last Updated By",
        "AssemblyTimeToBuild" => "AssemblyTimeToBuild",
        "AssemblyTimeToBuildUnit" => "AssemblyTimeToBuildUnit"
    ];

    public $detailPages = [
        "Main" => [
            "viewPath" => "MRP/BillofMaterials/ViewBillOfMaterialsDetail",
            "newKeyField" => "AssemblyID",
            "keyFields" => ["AssemblyID", "ItemID"],
            "detailIdFields" => ["CompanyID","DivisionID","DepartmentID","AssemblyID", "ItemID"],
            "gridFields" => [
                "AssemblyID" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "ItemID" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "NumberOfItemsInAssembly" => [
                    "dbType" => "int(11)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "WarehouseID" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "LaborCost" => [
                    "dbType" => "decimal(19,4)",
                    "format" => "{0:n}",
                    "inputType" => "text",
                    "defaultValue" => ""
                ]
            ]
        ],
        "Assembly Instructions" => [
            "hideFields" => "true",
            "viewPath" => "MRP/BillofMaterials/InventoryAssembliesInstructionsDetail",
            "newKeyField" => "AssemblyID",
            "keyFields" => ["AssemblyID"],
            "detailIdFields" => ["CompanyID","DivisionID","DepartmentID","AssemblyID"],
            "gridFields" => [
                "AssemblyID" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "AssemblyBuildInstructions" => [
                    "dbType" => "varchar(999)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "AssemblySchematicURL" => [
                    "dbType" => "varchar(120)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "AssemblyPictureURL" => [
                    "dbType" => "varchar(120)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "AssemblyDiagramURL" => [
                    "dbType" => "varchar(120)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "AssemblyOtherURL" => [
                    "dbType" => "varchar(120)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ],
                "AssemblyLastUpdated" => [
                    "dbType" => "datetime",
                    "inputType" => "datetime",
                    "defaultValue" => "now"
                ],
                "AssemblyLastUpdatedBy" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ]
            ]
        ]
    ];

    //getting rows for grid
    public function getMain($id){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->detailPages["Main"]["gridFields"] as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailPages["Main"]["detailIdFields"] as $key){
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

        $keyFields .= " AND AssemblyID='" . $id . "'";

        
        $result = DB::select("SELECT " . implode(",", $fields) . " from inventoryassemblies " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function deleteMain(){
        $user = Session::get("user");
        $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentsID", "AssemblyID", "ItemID"];
        $keyValues = explode("__", $_GET["item"]);
        $keyFields = "";
        $fcount = 0;
        foreach($idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        DB::delete("DELETE from inventoryasseblies " .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }
    
    //getting rows for grid
    public function getAssemblyInstructions($id){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->detailPages["Assembly Instructions"]["gridFields"] as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailPages["Assembly Instructions"]["detailIdFields"] as $key){
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

        $keyFields .= " AND AssemblyID='" . $id . "'";

        
        $result = DB::select("SELECT " . implode(",", $fields) . " from inventoryassembliesinstructions " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function deleteAssemblyInstructions(){
        $user = Session::get("user");
        $idFields = ["CompanyID","DivisionID","DepartmentID","AssemblyID"];
        $keyValues = explode("__", $_GET["item"]);
        $keyFields = "";
        $fcount = 0;
        foreach($idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        DB::delete("DELETE from inventoryassebliesinstructions " .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }
}
?>
