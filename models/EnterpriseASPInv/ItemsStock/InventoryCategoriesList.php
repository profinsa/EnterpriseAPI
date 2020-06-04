<?php
/*
  Name of Page: InventoryCategoriesList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryCategoriesList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Nikita Zaharov
   
  Use: this model used by views/InventoryCategoriesList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryCategoriesList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryCategoriesList.php
   
  Calls:
  MySql Database
   
  Last Modified: 07/05/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class InventoryCategoriesList extends gridDataSource{
    public $tableName = "inventorycategories";
    public $dashboardTitle ="Inventory Categories";
    public $breadCrumbTitle ="Inventory Categories";
    public $idField ="ItemCategoryID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemCategoryID","ItemFamilyID"];
    public $gridFields = [
        "ItemCategoryID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ItemFamilyID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "CategoryName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "CategoryDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "ItemCategoryID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => true
            ],
            "ItemFamilyID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getInventoryFamilies",
                "defaultValue" => ""
            ],
            "CategoryName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CategoryDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CategoryLongDescription" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CategoryPictureURL" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CategoryPicture" => [
                "dbType" => "varchar(80)",
                "urlField" => "CategoryPictureURL",
                "inputType" => "imageFile",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "ItemCategoryID" => "Item Category ID",
        "ItemFamilyID" => "Item Family ID",
        "CategoryName" => "Category Name",
        "CategoryDescription" => "Category Description",
        "CategoryLongDescription" => "Category Long Description",
        "CategoryPictureURL" => "Category Picture URL",
        "CategoryPicture" => "Category Picture"
    ];
}
?>
