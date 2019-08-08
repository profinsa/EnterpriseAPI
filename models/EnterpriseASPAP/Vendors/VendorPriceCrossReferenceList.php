<?php
/*
  Name of Page: VendorPriceCrossReferenceList model
   
  Method: Model for gridView. It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 NikitaZaharov
   
  Use: this model used by views/VendorPriceCrossReferenceList for:
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
   
  Last Modified: 04/13/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "vendorpricecrossreference";
    public $dashboardTitle ="Vendor Price Cross Reference";
    public $breadCrumbTitle ="Vendor Price Cross Reference";
    public $idField ="VendorID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID","ItemPricingCode"];
    public $gridFields = [
        "VendorID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "ItemPricingCode" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ItemPrice" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "Freight" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "Handling" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "Advertising" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "Shipping" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "VendorID" => [
                "dbType" => "varchar(50)",
                "inputType" => "dialogChooser",
                "dataProvider" => "getVendors",
                "disabledEdit" => true,
                "defaultValue" => ""
            ],
            "ItemPricingCode" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getInventoryPricingCodes",
                "disabledEdit" => true,
                "defaultValue" => ""
            ],
            "CurrencyID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemPrice" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Freight" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Handling" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Advertising" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Shipping" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];

    public $columnNames = [
        "VendorID" => "Vendor ID",
        "ItemPricingCode" => "Item Pricing Code",
        "ItemPrice" => "Item Price",
        "Freight" => "Freight",
        "Handling" => "Handling",
        "Advertising" => "Advertising",
        "Shipping" => "Shipping",
        "CurrencyID" => "Currency ID"
    ];
}
?>
