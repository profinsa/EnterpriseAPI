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
   
  Last Modified: 03/04/2019
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
        ],
        "Website" => [
            "AboutUsPage" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "AboutUsPageContent" => [
                "dbType" => "mediumtext",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerService" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "CustomerServiceContent" => [
                "dbType" => "mediumtext",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PrivacyPolicy" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "PrivacyPolicyContent" => [
                "dbType" => "mediumtext",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SiteMap" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SiteMapContent" => [
                "dbType" => "mediumtext",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Contact" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ContactContent" => [
                "dbType" => "mediumtext",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShippingReturns" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ShippingReturnsContent" => [
                "dbType" => "mediumtext",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SecureShopping" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SecureShoppingContent" => [
                "dbType" => "mediumtext",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "InternationalShipping" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "InternationalShippingContent" => [
                "dbType" => "mediumtext",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Affiliates" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "AffiliatesContent" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Help" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "HelpContent" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Support" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SupportContent" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ],
        "News Letter Signup" => [
            "ShowNewsletter" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ],
        "Socials" => [
            "Facebook" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "FacebookUrl" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Twitter" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "TwitterUrl" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LinkedIn" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "LinkedInUrl" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GooglePlus" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GooglePlusUrl" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Instagram" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "InstagramUrl" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "YouTube" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "YouTubeUrl" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Payment Methods" => [
            "Visa" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Master" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Discover" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Amex" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "PayPal" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Square" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
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
        "AboutUsPage" => "AboutUs Page",
        "AboutUsPageContent" => "AboutUs Page Content",
        "CustomerService" => "Customer Service",
        "CustomerServiceContent" => "Customer Service Content",
        "PrivacyPolicy" => "Privacy Policy",
        "PrivacyPolicyContent" => "Privacy Policy Content",
        "SiteMap" => "SiteMap",
        "SiteMapContent" => "Site Map Content",
        "Contact" => "Contact",
        "ContactContent" => "Contact Content",
        "ShippingReturns" => "Shipping Returns",
        "ShippingReturnsContent" => "Shipping Returns Content",
        "SecureShopping" => "Secure Shopping",
        "SecureShoppingContent" => "Secure Shopping Content",
        "InternationalShipping" => "International Shipping",
        "InternationalShippingContent" => "International Shipping Content",
        "Affiliates" => "Affiliates",
        "AffiliatesContent" => "Affiliates Content",
        "Help" => "Help",
        "HelpContent" => "Help Content",
        "Support" => "Support",
        "SupportContent" => "Support Content",
        "ShowNewsletter" => "Show News letter",
        "Facebook" => "Facebook",
        "FacebookUrl" => "Facebook Url",
        "Twitter" => "Twitter",
        "TwitterUrl" => "Twitter Url",
        "LinkedIn" => "LinkedIn",
        "LinkedInUrl" => "LinkedIn Url",
        "GooglePlus" => "Google Plus",
        "GooglePlusUrl" => "Google Plus Url",
        "Instagram" => "Instagram",
        "InstagramUrl" => "Instagram Url",
        "YouTube" => "YouTube",
        "YouTubeUrl" => "YouTube Url",
        "Visa" => "Visa",
        "Master" => "Master",
        "Discover" => "Discover",
        "Amex" => "Amex",
        "PayPal" => "PayPal",
        "Square" => "Square",
        "Approved" => "Approved",
        "ApprovedBy" => "Approved By"
    ];
}
?>
