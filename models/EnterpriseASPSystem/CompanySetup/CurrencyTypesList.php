<?php
/*
  Name of Page: CurrencyTypesList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CurrencyTypesList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/CurrencyTypesList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CurrencyTypesList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CurrencyTypesList.php
   
  Calls:
  MySql Database
   
  Last Modified: 04/07/2017
  Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "currencytypes";
    public $dashboardTitle ="Currencies";
    public $breadCrumbTitle ="Currencies";
    public $idField ="CurrencyID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","CurrencyID"];
    public $gridFields = [
        "CurrencyID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text"
        ],
        "CurrencyType" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "CurrenycySymbol" => [
            "dbType" => "varchar(1)",
            "inputType" => "text"
        ],
        "CurrencyExchangeRate" => [
            "dbType" => "float",
            "inputType" => "text"
        ],
        "CurrencyRateLastUpdate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyType" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrenycySymbol" => [
                "dbType" => "varchar(1)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyRateLastUpdate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "CurrencyPrecision" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "MajorUnits" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "MinorUnits" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "CurrencyID" => "Currency ID",
        "CurrencyType" => "Currency Type",
        "CurrenycySymbol" => "Currenycy Symbol",
        "CurrencyExchangeRate" => "Exchange Rate",
        "CurrencyRateLastUpdate" => "Rate Last Updated",
        "CurrencyPrecision" => "Currency Precision",
        "MajorUnits" => "Major Units",
        "MinorUnits" => "Minor Units"
    ];
}
?>
