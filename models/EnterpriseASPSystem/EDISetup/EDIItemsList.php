<?php
/*
  Name of Page: EDI Items

  Method: Model for grid and detail sceens. It provides data from database and default values, column names and categories

  Date created: 20/02/2019 Zaharov Nikita

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

  Last Modified: 20/02/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "ediitems";
    public $dashboardTitle ="EDI Items";
    public $breadCrumbTitle ="EDI Items";
	public $idField ="ItemID";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID", "ReferenceID"];
    public $gridFields = [
        "ItemID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ReferenceID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ItemDescription" => [
            "dbType" => "varchar(80)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ReferenceDescription" => [
            "dbType" => "varchar(80)",
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
        "Quantity" => [
            "dbType" => "bigint(20)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "ItemID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => true,
            ],
            "ReferenceID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => true,
            ],
            "ItemDescription" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ReferenceDescription" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EDIDirectionTypeID" => [
                "dbType" => "varchar(1)",
                "inputType" => "dropdown",
                "dataProvider" => "getEDIDirectionTypeIDs",
                "defaultValue" => ""
            ],
            "EDIDocumentTypeID" => [
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "dataProvider" => "getEDIDocumentTypeIDs",
                "defaultValue" => ""
            ],
            "EDIOpen" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "UPCCode" => [
                "dbType" => "varchar(12)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EPCCode" => [
                "dbType" => "varchar(12)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RFIDCode" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemCategory" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemFamily" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemWeight" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ItemUOM" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "UOMBasis" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Length" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Width" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Height" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Quantity" => [
                "dbType" => "bigint(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NRFColor" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NRFStyle" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "ItemID" => "Item ID",
        "ReferenceID" => "Reference ID",
        "ItemDescription" => "Description",
        "ReferenceDescription" => "Reference Description",
        "EDIDirectionTypeID" => "Direction Type ID",
        "EDIDocumentTypeID" => "Document Type ID",
        "EDIOpen" => "EDI Open",
        "UPCCode" => "UPC Code",
        "EPCCode" => "EPC Code",
        "RFIDCode" => "RFID Code",
        "ItemCategory" => "Item Category",
        "ItemFamily" => "Item Family",
        "ItemWeight" => "Item Weight",
        "ItemUOM" => "Item UOM",
        "UOMBasis" => "UOM Basis",
        "Length" => "Length",
        "Width" => "Width",
        "Height" => "Height",
        "Quantity" => "Quantity",
        "NRFColor" => "NRF Color",
        "NRFStyle" => "NRF Style"
    ];
}
?>
