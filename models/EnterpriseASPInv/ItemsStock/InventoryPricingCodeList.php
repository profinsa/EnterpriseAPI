<?php
/*
  Name of Page: InventoryPricingCodeList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryPricingCodeList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Nikita Zaharov
   
  Use: this model used by views/InventoryPricingCodeList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryPricingCodeList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ItemStock\InventoryPricingCodeList.php
   
  Calls:
  MySql Database
   
  Last Modified: 13/03/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class InventoryPricingCodeList extends gridDataSource{
    public $tableName = "inventorypricingcode";
    public $dashboardTitle ="Inventory Pricing Code";
    public $breadCrumbTitle ="Inventory Pricing Code";
    public $idField ="ItemID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","ItemPricingCode"];
    public $gridFields = [
        "ItemID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ItemPricingCode" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "Price" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "SalesPrice" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "SaleStartDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "SaleEndDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "ItemID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => true
            ],
            "ItemPricingCode" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => true
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
            "Price" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "MSRP" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HotItem" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "FeaturedItem" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SaleItem" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SalesPrice" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SaleStartDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "SaleEndDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "Approved" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApprovedBy" => [
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
        "ItemID" => "Item ID",
        "ItemPricingCode" => "Pricing Code",
        "Price" => "Price",
        "SalesPrice" => "Sales Price",
        "SaleStartDate" => "Sale Start Date",
        "SaleEndDate" => "Sale End Date",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "MSRP" => "MSRP",
        "HotItem" => "Hot Item",
        "FeaturedItem" => "Featured Item",
        "SaleItem" => "Sale Item",
        "Approved" => "Approved",
        "ApprovedBy" => "Approved By",
        "ApprovedDate" => "Approved Date",
        "EnteredBy" => "Entered By"
    ];
}
?>
