<?php
/*
  Name of Page: AppInstallations

  Method: Model for grid and detail sceens. It provides data from database and default values, column names and categories

  Date created: 30/08/2019 NikitaZaharov

  Use: this model used by gridView for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by controllers
  used as model by 

  Calls:
  MySql Database

  Last Modified: 30/08/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "AppInstallations";
    public $dashboardTitle ="AppInstallations";
    public $breadCrumbTitle ="AppInstallations";
    public $idField ="CustomerID";
    public $idFields = ["CustomerID"];
    public $gridFields = [
        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SoftwareID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "InstallationName" => [
            "dbType" => "varchar(100)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ExpirationDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "Active" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "LoggedIn" => [
            "dbType" => "int(11)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "dialogChooser",
                "dataProvider" => "getCustomers",
                "defaultValue" => ""
            ],
            "SoftwareID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ConfigName" => [
                "dbType" => "varchar(100)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "InstallationName" => [
                "dbType" => "varchar(100)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "InstallationDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ExpirationDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "Active" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "LoggedIn" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "CustomerID" => "Customer ID",
        "SoftwareID" => "Software ID",
        "ConfigName" => "Config Name",
        "InstallationName" => "Installation Name",
        "InstallationDate" => "Installation Date",
        "ExpirationDate" => "Expiration Date",
        "Active" => "Active",
        "LoggedIn" => "Logged In"
    ];
}
?>
