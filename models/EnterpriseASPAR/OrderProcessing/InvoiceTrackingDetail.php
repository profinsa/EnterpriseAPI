<?php
/*
  Name of Page: InvoiceTrackingdDetail model

  Method: Model for gridView. It provides data from database and default values, column names and categories

  Date created: 05/31/2017 Nikita Zaharov

  Use: this model used by gridViews for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by Grid controlle
  used as model by gridView

  Calls:
  MySql Database

  Last Modified: 05/31/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "invoicetrackingdetail";
    public $dashboardTitle ="Invoice Tracking Detail";
    public $breadCrumbTitle ="Invoice Tracking Detail";
    public $idField ="InvoiceNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","InvoiceNumber", "CommentNumber"];
    public $gridFields = [
        "InvoiceNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CommentNumber" => [
            "dbType" => "decimal(18,0)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "InvoiceNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => "true",
                "disabledNew" => "true"
            ],
            "CommentNumber" => [
                "dbType" => "decimal(18,0)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CommentDate" => [
                "dbType" => "char10",
                "inputType" => "text",
                "defaultValue" => ""
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
        ]
    ];
    
    public $columnNames = [
        "InvoiceNumber" => "Invoice Number",
        "CommentNumber" => "Comment Number",
        "CommentDate" => "Comment Date",
        "Comment" => "Comment",
        "CommentDetails" => "Comment Details",
        "Approved" => "Approved",
        "ApprovedBy" => "Approved By",
        "ApprovedDate" => "Approved Date" 
    ];
}
?>
