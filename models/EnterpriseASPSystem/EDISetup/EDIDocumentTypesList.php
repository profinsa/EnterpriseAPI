<?php
/*
  Name of Page: EDIDocumentTypes

  Method: Model for grid and detail sceens. It provides data from database and default values, column names and categories

  Date created: 19/02/2019 NikitaZaharov

  Use: this model used by gridView for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by controllers
  used as model by 

  Calls:
  MySql Database

  Last Modified: 19/02/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "edidocumenttypes";
    public $dashboardTitle ="EDI Document Types";
    public $breadCrumbTitle ="EDI Document Types";
	public $idField ="EDIDocumentTypeID";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","EDIDocumentTypeID"];
    public $gridFields = [
        "EDIDocumentTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EDIDocumentDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "EDIDocumentTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "EDIDocumentDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "EDIDocumentTypeID" => "EDI Document Type ID",
        "EDIDocumentDescription" => "EDI Document Description"
    ];
}
?>
