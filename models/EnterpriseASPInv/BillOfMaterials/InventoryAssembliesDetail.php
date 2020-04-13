<?php
/*
  Name of Page: Inventory Assemblies Detail model

  Method: Model for grid controller. It provides data from database and default values, column names and categories

  Date created: 03/07/2019

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
  created and used for ajax requests by grid controllers
  used as model by views/gridView

  Calls:
  MySql Database
   
  Last Modified: 03/07/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    public $tableName = "inventoryassemblies";
    public $dashboardTitle ="Inventory Assemblies Detail";
    public $breadCrumbTitle ="Inventory Assemblies Detail";
    public $idField ="AssemblyID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","AssemblyID","ItemID"];
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
                "disabledNew" => "true",
                "disabledEdit" => "edit"
            ],
            "ItemID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getCurrencyTypes"
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
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getWarehouses"
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
        "EnteredBy" => "Entered By"
    ];
}
?>
