<?php
/*
  Name of Page: EDISetup

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
class EDISetupList extends gridDataSource{
    public $tableName = "edisetup";
    public $dashboardTitle ="EDI Setup";
    public $breadCrumbTitle ="EDI Setup";
	public $idField ="EDIID";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","EDIID"];
    public $gridFields = [
        "EDIActive" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "EDIQualifier" => [
            "dbType" => "varchar(2)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EDIID" => [
            "dbType" => "varchar(10)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EDITestQualifier" => [
            "dbType" => "varchar(2)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EDITestID" => [
            "dbType" => "varchar(10)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "EDIID" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "EDIActive" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIQualifier" => [
                "dbType" => "varchar(2)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EDITestQualifier" => [
                "dbType" => "varchar(2)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EDITestID" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EDIInboundOrders" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIOutboundOrders" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIInboundInvoices" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIOutboundInvoices" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIInboundASN" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIOutboundASN" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIInboundUPC" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIOutboundUPC" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIInboundFinancial" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIOutboundFinancial" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIInboundOrderStatus" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIOutboundOrderStatus" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIInboundInventory" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIOutboundInventory" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ]
    ];
    
    public $columnNames = [
        "EDIID" => "EDI ID",
        "EDIActive" => "EDI Active",
        "EDIQualifier" => "EDI Qualifier",
        "EDITestQualifier" => "EDI Test Qualifier",
        "EDITestID" => "EDI Test ID",
        "EDIInboundOrders" => "EDI Inbound Orders",
        "EDIOutboundOrders" => "EDI Outbound Orders",
        "EDIInboundInvoices" => "EDI Inbound Invoices",
        "EDIOutboundInvoices" => "EDI Outbound Invoices",
        "EDIInboundASN" => "EDI Inbound ASN",
        "EDIOutboundASN" => "EDI Outbound ASN",
        "EDIInboundUPC" => "EDI Inbound UPC",
        "EDIOutboundUPC" => "EDI Outbound UPC",
        "EDIInboundFinancial" => "EDI Inbound Financial",
        "EDIOutboundFinancial" => "EDI Outbound Financial",
        "EDIInboundOrderStatus" => "EDI Inbound Order Status",
        "EDIOutboundOrderStatus" => "EDI Outbound Order Status",
        "EDIInboundInventory" => "EDI Inbound Inventory",
        "EDIOutboundInventory" => "EDI Outbound Inventory"
    ];
}
?>
