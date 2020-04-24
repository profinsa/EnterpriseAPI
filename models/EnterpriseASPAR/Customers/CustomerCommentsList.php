<?php
/*
  Name of Page: CustomerCommentsList model
   
  Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerCommentsList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/CustomerCommentsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerCommentsList.php
  used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerCommentsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 08/14/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class CustomerCommentsList extends gridDataSource{
    public $tableName = "customercomments";
    public $dashboardTitle ="Customer Comments";
    public $breadCrumbTitle ="Customer Comments";
    public $idField ="CustomerID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","CommentLineID"];
    public $gridFields = [
        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "CommentLineID" => [
            "dbType" => "int(11)",
            "inputType" => "text"
        ],
        "CommentDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "CommentType" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "Comment" => [
            "dbType" => "varchar(255)",
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
            "CommentLineID" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CommentDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "CommentType" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Comment" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "CustomerID" => "Customer ID",
        "CommentLineID" => "Line ID",
        "CommentDate" => "Comment Date",
        "CommentType" => "Comment Type",
        "Comment" => "Comment"];
}
?>
