<?php
/*
  Name of Page: CustomerPriceCrossReferenceList model
   
  Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerPriceCrossReferenceList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/CustomerPriceCrossReferenceList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerPriceCrossReferenceList.php
  used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerPriceCrossReferenceList.php
   
  Calls:
  MySql Database
   
  Last Modified: 08/08/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class CustomerPriceCrossReferenceList extends gridDataSource{
    public $tableName = "customerpricecrossreference";
    public $dashboardTitle ="Customer Price Cross Reference";
    public $breadCrumbTitle ="Customer Price Cross Reference";
    public $idField ="CustomerID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ItemPricingCode"];
    public $gridFields = [
        "CustomerID" => [
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
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "dialogChooser",
                "dataProvider" => "getCustomers",
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
            "ItemPrice" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
				"inputType" => "dropdown",
                "dataProvider" => "getCurrencyTypes",
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
        "CustomerID" => "Customer ID",
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
