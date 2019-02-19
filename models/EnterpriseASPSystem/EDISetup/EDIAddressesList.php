<?php
/*
  Name of Page: EDI Addresses

  Method: Model for grid and detail sceens. It provides data from database and default values, column names and categories

  Date created: 19/02/2019 NikitaZaharov

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

  Last Modified: 19/02/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "ediaddresses";
    public $dashboardTitle ="EDI Addresses";
    public $breadCrumbTitle ="EDI Addresses";
	public $idField ="ReferenceID";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","ReferenceID", "ReferenceAddressShipTo"];
    public $gridFields = [
        "ReferenceID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ReferenceAddressShipTo" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ReferenceAddressShipFor" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EDIDirectionTypeID" => [
            "dbType" => "varchar(1)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
    ];

    public $editCategories = [
        "Main" => [
            "ReferenceID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => true
            ],
            "ReferenceAddressShipTo" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => true
            ],
            "ReferenceAddressShipFor" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EDIDirectionTypeID" => [
                "dbType" => "varchar(1)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EDIDocumentTypeID" => [
                "dbType" => "varchar(3)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EDIOpen" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ShipName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipAddress1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipAddress2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipAddress3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipCity" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipState" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipZip" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipCountry" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipAttention" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipPhone" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipFax" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipEmail" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipWebPage" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ShipNotes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];

    public $columnNames = [
        "ReferenceID" => "Reference ID",
        "ReferenceAddressShipTo" => "Reference Address Ship To",
        "ReferenceAddressShipFor" => "Reference Address Ship For",
        "EDIDirectionTypeID" => "EDI Direction Type ID",
        "EDIDocumentTypeID" => "EDI Document Type ID",
        "EDIOpen" => "EDI Open",
        "ShipName" => "Ship Name",
        "ShipAddress1" => "Ship Address 1",
        "ShipAddress2" => "Ship Address 2",
        "ShipAddress3" => "Ship Address 3",
        "ShipCity" => "Ship City",
        "ShipState" => "Ship State",
        "ShipZip" => "Ship Zip",
        "ShipCountry" => "Ship Country",
        "ShipAttention" => "Ship Attention",
        "ShipPhone" => "Ship Phone",
        "ShipFax" => "Ship Fax",
        "ShipEmail" => "Ship Email",
        "ShipWebPage" => "Ship Web Page",
        "ShipNotes" => "Ship Notes"
    ];
}
?>
