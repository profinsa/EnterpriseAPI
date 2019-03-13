<?php
/*
  Name of Page: InventoryCartDetail model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryCartDetail.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Nikita Zaharov

  Use: this model used by views/InventoryCartDetail for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryCartDetail.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\ShoppingCartSetup\InventoryCartDetail.php
   
  Calls:
  MySql Database
   
  Last Modified: 13/03/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "inventorycart";
    public $dashboardTitle ="Cart Setup";
    public $breadCrumbTitle ="Cart Setup";
    public $idField ="undefined";
    public $idFields = ["CompanyID","DivisionID","DepartmentID"];
    public $gridFields = [
        "DefaultPricingCode" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "RestockingFee" => [
            "dbType" => "float",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "MinimumOrderAmount" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "ApprovedDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "UsePricingCodes" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "UseCustomerSpecificPricing" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "DefaultPricingCode" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemOrDefaultWarehouse" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "DefaultWarehouse" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultOverride" => true,
                "dataProvider" => "getWarehouses",
                "defaultValue" => "ECommerce"
            ],
            "DefaultBin" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "depends" => [
                    "WarehouseID" => "WarehouseID"
                ],
                "dataProvider" => "getWarehouseBins",
                "defaultOverride" => true,
                "defaultValue" => "DEFAULT"
            ],
            "CheckStock" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ShowStock" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "HideOutOfStockItems" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "OfferSubstitute" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ShowFeatures" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ShowSales" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ShowCrossSell" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ShowRelations" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ShowReviews" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ShowWishList" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ShowItemNotifications" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ShowRMA" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ChargeRestockingFee" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "RestockingFee" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "MinimumOrder" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "MinimumOrderAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "MultiCurrency" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "MultiLanguage" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GiftsOrCoupons" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
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
            ]
        ]
    ];
    
    public $columnNames = [
        "DefaultPricingCode" => "Default Pricing Code",
        "RestockingFee" => "Restocking Fee",
        "MinimumOrderAmount" => "Minimum Order Amount",
        "ApprovedDate" => "Approved Date",
        "UsePricingCodes" => "Use Pricing Codes",
        "UseCustomerSpecificPricing" => "Use Customer Specific Pricing",
        "ItemOrDefaultWarehouse" => "Item Or Default Warehouse",
        "DefaultWarehouse" => "Default Warehouse",
        "DefaultBin" => "Default Bin",
        "CheckStock" => "Check Stock",
        "ShowStock" => "Show Stock",
        "HideOutOfStockItems" => "Hide Out Of Stock Items",
        "OfferSubstitute" => "Offer Substitute",
        "ShowFeatures" => "Show Features",
        "ShowSales" => "Show Sales",
        "ShowCrossSell" => "Show Cross Sell",
        "ShowRelations" => "Show Relations",
        "ShowReviews" => "Show Reviews",
        "ShowWishList" => "Show Wish List",
        "ShowItemNotifications" => "Show Item Notifications",
        "ShowRMA" => "Show RMA",
        "ChargeRestockingFee" => "Charge Restocking Fee",
        "MinimumOrder" => "Minimum Order",
        "MultiCurrency" => "Multi Currency",
        "MultiLanguage" => "Multi Language",
        "GiftsOrCoupons" => "Gifts Or Coupons",
        "Approved" => "Approved",
        "ApprovedBy" => "Approved By"
    ];
}
?>
