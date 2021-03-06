<?php
/*
  Name of Page: Help Document Module model
   
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
class HelpDocumentModuleList extends gridDataSource{
    public $tableName = "helpdocumentmodule";
    public $dashboardTitle ="Help Document Module";
    public $breadCrumbTitle ="Help Document Module";
    public $idField ="DocumentModuleID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","ModuleID"];
    public $gridFields = [
        "ModuleID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ModuleName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ModuleDescription" => [
            "dbType" => "varchar(60)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "ModuleID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => true,
                "defaultValue" => ""
            ],
            "ModuleName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ModuleDescription" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ModuleLongDescription" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ModulePictureURL" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ModulePicture" => [
                "dbType" => "varchar(80)",
                "inputType" => "imageFile",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "ModuleID" => "Module ID",
        "ModuleName" => "Module Name",
        "ModuleDescription" => "Module Description",
        "ModuleLongDescription" => "Module Long Description",
        "ModulePictureURL" => "Module Picture URL",
        "ModulePicture" => "Module Picture"
    ];
}
?>
