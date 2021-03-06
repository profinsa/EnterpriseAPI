<?php
/*
  Name of Page: EDI Exception Types

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
class EDIExceptionTypesList extends gridDataSource{
    public $tableName = "ediexceptiontypes";
    public $dashboardTitle ="EDI Exception Types";
    public $breadCrumbTitle ="EDI Eexception Types";
	public $idField ="ExceptionTypeID";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","ExceptionTypeID"];
    public $gridFields = [
        "ExceptionTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ExceptionTypeDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "ExceptionTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => true,
                "defaultValue" => ""
            ],
            "ExceptionTypeDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "ExceptionTypeID" => "Exception Type ID",
        "ExceptionTypeDescription" => "Exception Type Description"
    ];
}
?>
