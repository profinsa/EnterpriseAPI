<?php
/*
  Name of Page: CustomerShipForLocationsList model
   
  Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerShipForLocationsList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/CustomerShipForLocationsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerShipForLocationsList.php
  used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerShipForLocationsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 04/08/2017
  Last Modified by: Kenna Fetterman
*/

require "./models/gridDataSource.php";
class CustomerShipForLocationsList extends gridDataSource{
    public $tableName = "customershipforlocations";
    public $dashboardTitle ="Customer Ship For Locations";
    public $breadCrumbTitle ="Customer Ship For Locations";
    public $idField ="CustomerID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ShipToID","ShipForID"];
    public $gridFields = [

        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "ShipToID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ShipForID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ShipForName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "ShipForAttention" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [

            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipToID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipForID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipForName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipForAddress1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipForAddress2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipForAddress3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipForCity" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipForState" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipForZip" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipForeCountry" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipForEmail" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipForWebPage" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipForAttention" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipForNotes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]];
    public $columnNames = [

        "CustomerID" => "Customer ID",
        "ShipToID" => "Ship To ID",
        "ShipForID" => "Ship For ID",
        "ShipForName" => "Ship For Name",
        "ShipForAttention" => "Ship For Attention",
        "ShipForAddress1" => "Ship For Address 1",
        "ShipForAddress2" => "Ship For Address 2",
        "ShipForAddress3" => "Ship For Address 3",
        "ShipForCity" => "Ship For City",
        "ShipForState" => "Ship For State",
        "ShipForZip" => "Ship For Zip",
        "ShipForeCountry" => "Ship Fore Country",
        "ShipForEmail" => "Ship For Email",
        "ShipForWebPage" => "Ship For Web Page",
        "ShipForNotes" => "Ship For Notes"];
}?>
