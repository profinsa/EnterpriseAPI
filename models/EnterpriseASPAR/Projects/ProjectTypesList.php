<?php
/*
  Name of Page: ProjectTypesList model
   
  Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Projects\ProjectTypesList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/ProjectTypesList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Projects\ProjectTypesList.php
  used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Projects\ProjectTypesList.php
   
  Calls:
  MySql Database
   
  Last Modified: 08/14/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class ProjectTypesList extends gridDataSource{
    public $tableName = "projecttypes";
    public $dashboardTitle ="Project Types";
    public $breadCrumbTitle ="Project Types";
    public $idField ="ProjectTypeID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","ProjectTypeID"];
    public $gridFields = [

        "ProjectTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ProjectTypeDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [

            "ProjectTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProjectTypeDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]];
    public $columnNames = [

        "ProjectTypeID" => "Project Type ID",
        "ProjectTypeDescription" => "Project Type Description"];
}?>
