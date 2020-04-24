<?php
/*
  Name of Page: EDIDirection

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
class EDIDirectionList extends gridDataSource{
    public $tableName = "edidirection";
    public $dashboardTitle ="EDI Direction";
    public $breadCrumbTitle ="EDI Direction";
	public $idField ="DirectionTypeID";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","DirectionTypeID"];
    public $gridFields = [
        "DirectionTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "DirectionTypeDescription" => [
            "dbType" => "varchar(15)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "DirectionTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "DirectionTypeDescription" => [
                "dbType" => "varchar(15)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "DirectionTypeID" => "Direction Type ID",
        "DirectionTypeDescription" => "Direction Type Description"
    ];
}
?>
