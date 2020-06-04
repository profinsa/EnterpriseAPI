<?php
/*
  Name of Page: InventoryAdjustmentTypesList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\InventoryAdjustments\InventoryAdjustmentTypesList.php It provides data from database and default values, column names and categories
   
  Date created: 16/02/2017 Nikita Zaharov
   
  Use: this model used by views/InventoryAdjustmentTypesList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\InventoryAdjustments\InventoryAdjustmentTypesList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\InventoryAdjustments\InventoryAdjustmentTypesList.php
   
  Calls:
  MySql Database
   
  Last Modified: 28/03/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class InventoryAdjustmentTypesList extends gridDataSource{
    public $tableName = "inventoryadjustmenttypes";
    public $dashboardTitle ="Inventory Adjustment Types";
    public $breadCrumbTitle ="Inventory Adjustment Types";
    public $idField ="AdjustmentTypeID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","AdjustmentTypeID"];
    public $gridFields = [
        "AdjustmentTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "AdjustmentTypeDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "AdjustmentTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => true,
                "defaultValue" => ""
            ],
            "AdjustmentTypeDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "AdjustmentTypeID" => "Adjustment Type ID",
        "AdjustmentTypeDescription" => "Adjustment Type Description"
    ];
}
?>
