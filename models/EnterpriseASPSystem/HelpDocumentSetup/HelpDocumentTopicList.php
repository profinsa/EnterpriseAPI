<?php
/*
  Name of Page: Help Document Topic model
   
  Method: Model for grid controller and view. It provides data from database and default values, column names and categories
   
  Date created: 20/06/2019 Zaharov Nikita
   
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
   
  Last Modified: 24/06/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
class HelpDocumentTopicList extends gridDataSource{
    public $tableName = "helpdocumenttopic";
    public $dashboardTitle ="Help Document Topic";
    public $breadCrumbTitle ="Help Document Topic";
    public $idField ="TopicID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","TopicID"];
    public $gridFields = [
        "TopicID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TopicName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TopicDescription" => [
            "dbType" => "varchar(60)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "TopicID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => true,
                "defaultValue" => ""
            ],
            "TopicName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TopicDescription" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TopicLongDescription" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TopicPictureURL" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TopicPicture" => [
                "dbType" => "varchar(80)",
                "inputType" => "imageFile",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "TopicID" => "Topic ID",
        "TopicName" => "Topic Name",
        "TopicDescription" => "Topic Description",
        "TopicLongDescription" => "Topic Long Description",
        "TopicPictureURL" => "Topic Picture URL",
        "TopicPicture" => "Topic Picture"
    ];
}
?>
