<?php
/*
  Name of Page: Purchase Tracking Detail model

  Method: Model for gridView. It provides data from database and default values, column names and categories

  Date created: 06/16/2017

  Use: this model used by views/PurchaseTrackingHeaderList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests Grid controller
  used as model by gridView

  Calls:
  MySql Database

  Last Modified: 08/15/2017
  Last Modified by: Niktia Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "purchasetrackingdetail";
    public $dashboardTitle ="Purchase Tracking Detail";
    public $breadCrumbTitle ="Purchase Tracking Detail";
    public $idField ="PurchaseNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","PurchaseNumber"];
    public $gridFields = [
        "PurchaseNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CommentNumber" => [
            "dbType" => "decimal(18,0)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CommentDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "Comment" => [
            "dbType" => "varchar(255)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CommentDetails" => [
            "dbType" => "varchar(255)",
            "inputType" => "text",
            "defaultValue" => ""
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
    ];

    public $editCategories = [
        "Main" => [
            "PurchaseNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => ""
            ],
            "CommentNumber" => [
                "dbType" => "decimal(18,0)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CommentDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "Comment" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CommentDetails" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Approved" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApprovedBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
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
        "PurchaseNumber" => "Purchase Number",
        "PurchaseDescription" => "Purchase Description",
        "SpecialInstructions" => "Special Instructions",
        "SpecialNeeds" => "Special Needs",
        "EnteredBy" => "Entered By",
        "PurchaseLongDescription" => "Purchase Long Description",
        "Approved" => "Approved",
        "ApprovedBy" => "Approved By",
        "ApprovedDate" => "Approved Date",
        "CommentNumber" => "Comment Number",
        "CommentDate" => "Comment Date",
        "Comment" => "Comment",
        "CommentDetails" => "Comment Details",
    ];
}
?>
