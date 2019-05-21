<?php
/*
  Name of Page: WarehouseTransitHeaderList model
   
  Method: Model for gridView. It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Nikita Zaharov
   
  Use: this model used by views/WarehouseTransitHeaderList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by grid controller
  used as model by views/gridView
   
  Calls:
  MySql Database
   
  Last Modified: 21/05/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "warehousetransitheader";
    public $dashboardTitle ="WarehouseTransitHeader";
    public $breadCrumbTitle ="WarehouseTransitHeader";
    public $idField ="TransitID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","TransitID"];
    public $gridFields = [
        "TransitID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "TransitEnteredDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "TransitETAlDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "TransitShipVia" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "TransitShipped" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "TransitShipDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "TransitTrackingNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TransitBillOfLadingNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TransitTralierNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TransitTrailerPrefix" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "TransitShippingInstructions" => [
            "dbType" => "varchar(255)",
            "inputType" => "text"
        ],
    ];

    public $editCategories = [
        "Main" => [
            "TransitID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitEnteredDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "TransitETAlDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "TransitShipVia" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitShipped" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "TransitShipDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "TransitTrackingNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitBillOfLadingNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitTralierNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitTrailerPrefix" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitShippingInstructions" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitReceived" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "TransitReceivedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "TransitRequestedBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Memorized" => [
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
            ],
            "EnteredBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
        ],
        "Memos" => [
            "TransitHeaderMemo1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitHeaderMemo2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitHeaderMemo3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitHeaderMemo4" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitHeaderMemo5" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitHeaderMemo6" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitHeaderMemo7" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitHeaderMemo8" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitHeaderMemo9" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransitHeaderMemo10" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Signature" => [
            "Signature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SignaturePassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupervisorSignature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupervisorSignaturePassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ManagerSignature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ManagerSignaturePassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Transit Detail" => [
            "TransitID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "TransitID" => "Transit ID",
        "TransitEnteredDate" => "Entered Date",
        "TransitETAlDate" => "ETAl Date",
        "TransitShipVia" => "Ship Via",
        "TransitShipDate" => "Ship Date",
        "TransitTrailerPrefix" => "Trailer Prefix",
        "TransitShippingInstructions" => "Shipping Instructions",
        "TransitReceivedDate" => "Received Date",
        "TransitRequestedBy" => "Requested By",
        "ApprovedBy" => "Approved By",
        "ApprovedDate" => "Approved Date",
        "EnteredBy" => "Entered By",
        "TransitHeaderMemo1" => "Memo 1",
        "TransitHeaderMemo2" => "Memo 2",
        "TransitHeaderMemo3" => "Memo 3",
        "TransitHeaderMemo4" => "Memo 4",
        "TransitHeaderMemo5" => "Memo 5",
        "TransitHeaderMemo6" => "Memo 6",
        "TransitHeaderMemo7" => "Memo 7",
        "TransitHeaderMemo8" => "Memo 8",
        "TransitHeaderMemo9" => "Memo 9",
        "TransitHeaderMemo10" => "Memo 10",
        "Signature" => "Signature",
        "SignaturePassword" => "Signature Password",
        "SupervisorSignature" => "Supervisor Signature",
        "SupervisorSignaturePassword" => "Supervisor Signature Password",
        "ManagerSignature" => "Manager Signature",
        "ManagerSignaturePassword" => "Manager Signature Password",
        "TransitShipped" => "Shipped",
        "TransitTrackingNumber" => "Tracking #",
        "TransitBillOfLadingNumber" => "Bill Of Lading #",
        "TransitTralierNumber" => "Trailier #",
        "TransitReceived" => "Transit Received",
        "Memorized" => "Memorized",
        "Approved" => "Approved"
    ];
}
?>
