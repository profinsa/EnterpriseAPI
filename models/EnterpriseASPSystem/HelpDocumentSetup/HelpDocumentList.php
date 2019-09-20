<?php
/*
  Name of Page: Help Document model
   
  Method: Model for grid controllers and views. It provides data from database and default values, column names and categories
   
  Date created: 21/06/2019 Zaharov Nikita
   
  Use: this model used by views/gridView for:
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
   
  Last Modified: 20/09/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "helpdocument";
    public $dashboardTitle ="Help Document";
    public $breadCrumbTitle ="Help Document";
    public $idField ="DocumentTitleID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","DocumentTitleID"];
    public $gridFields = [
        "DocumentTitleID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "DocumentTitle" => [
            "dbType" => "varchar(128)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "DocumentTopic" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "DocumentModule" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "DocumentURL" => [
            "dbType" => "text",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "DocumentTitleID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => true,
                "defaultValue" => ""
            ],
            "DocumentTitle" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DocumentTopic" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getHelpDocumentTopics",
                "defaultValue" => ""
            ],
            "DocumentModule" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getHelpDocumentModules",
                "defaultValue" => ""
            ],
            "DocumentURL" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DocumentContents" => [
                "dbType" => "text",
                "inputType" => "textarea",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "DocumentTitleID" => "Document ID",
        "DocumentTitle" => "Document Title",
        "DocumentTopic" => "Document Topic",
        "DocumentModule" => "Document Module",
        "DocumentURL" => "Document URL",
        "DocumentContents" => "Document Contents"
    ];

    public function searchDocument(){
        echo $_POST["query"];
        //        DB::
    }
}
?>
