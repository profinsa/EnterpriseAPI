<?php
/*
  Name of Page: QuoteTrackingdDetail model

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

class QuoteTrackingDetail extends gridDataSource{
    public $tableName = "quotetrackingdetail";
    public $dashboardTitle ="Order Tracking Detail";
    public $breadCrumbTitle ="Order Tracking Detail";
    public $idField ="OrderNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","OrderNumber", "CommentNumber"];
    public $gridFields = [
        "OrderNumber" => [
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
            "OrderNumber" => [
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
        ]
    ];
    
    public $columnNames = [
        "OrderNumber" => "Order Number",
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
