<?php
/*
  Name of Page: LeadCommentsList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadCommentsList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/LeadCommentsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadCommentsList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadCommentsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 19/11/2018
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    public $tableName = "leadcomments";
    public $dashboardTitle ="Lead Comments";
    public $breadCrumbTitle ="Lead Comments";
    public $idField ="CommentNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","CommentNumber"];
    public $gridFields = [
        "LeadID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "CommentNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "CommentDate" => [
            "dbType" => "timestamp",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "CommentType" => [
            "dbType" => "varchar(15)",
            "inputType" => "text"
        ],
        "Comment" => [
            "dbType" => "varchar(255)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "CommentNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "LeadID" => [
                "dbType" => "varchar(50)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getLeadIds"
            ],
            "CommentDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "CommentType" => [
                "dbType" => "varchar(15)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getCommentTypes"
            ],
            "Comment" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "LeadID" => "Lead ID",
        "CommentNumber" => "Comment Number",
        "CommentDate" => "Comment Date",
        "CommentType" => "Comment Type",
        "Comment" => "Comment"
    ];
}
?>
