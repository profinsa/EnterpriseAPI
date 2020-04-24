<?php
/*
  Name of Page: InventoryItemTypesList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryItemTypesList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Nikita Zaharov
   
  Use: this model used by views/InventoryItemTypesList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryItemTypesList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryItemTypesList.php
   
  Calls:
  MySql Database
   
  Last Modified: 25/04/2019
  Last Modified by: Nikita Zaharov
*/
require "./models/gridDataSource.php";
class InventoryItemTypesList extends gridDataSource{
    public $tableName = "inventoryitemtypes";
    public $dashboardTitle ="InventoryItemTypes";
    public $breadCrumbTitle ="InventoryItemTypes";
    public $idField ="ItemTypeID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemTypeID"];
    public $gridFields = [
        "ItemTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ItemTypeDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "ItemTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => true
            ],
            "ItemTypeDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Serialized" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ]
    ];
    
    public $columnNames = [
        "ItemTypeID" => "Item Type ID",
        "ItemTypeDescription" => "Item Type Description",
        "Serialized" => "Serialized"
    ];
}
?>
