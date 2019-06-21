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
   
  Last Modified: 20/06/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "helpdocumentmodule";
    public $dashboardTitle ="Help Document Module";
    public $breadCrumbTitle ="Help Document Module";
    public $idField ="DocumentModuleID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","DocumentModuleID"];
    public $gridFields = [
        "DocumentModuleID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "DocumentModuleDescription" => [
            "dbType" => "varchar(60)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "DocumentModuleID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => true,
                "defaultValue" => ""
            ],
            "DocumentModuleDescription" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "DocumentModuleID" => "Document Module ID",
        "DocumentModuleDescription" => "Document Module Description"
    ];
}
?>
