<?php
/*
  Name of Page: HelpSupportRequestDetail
   
  Method: Model for grid screen. It provides data from database and default values, column names and categories
   
  Date created: 06/08/2019 Nikita Zaharov
   
  Use: this model used by views/gridView
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
   
  Last Modified: 07/08/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "helpsupportrequestdetail";
    public $dashboardTitle ="Help Support Request Detail";
    public $breadCrumbTitle ="Help Support Request Detail";
    public $idField ="CaseId";
    public $idFields = ["CompanyID", "DivisionID", "DepartmentID", "CaseId", "CaseIDDetail"];
    public $gridFields = [
        "CaseId" => [
            "dbType" => "bigint(20)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "Subject" => [
            "dbType" => "varchar(80)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "Created" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "Message" => [
            "dbType" => "varchar(999)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ScreenShotURL" => [
            "dbType" => "varchar(120)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CaseIDDetail" => [
            "dbType" => "int(11)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "CaseId" => [
                "dbType" => "bigint(20)",
                "inputType" => "text",
                "disabledEdit" => true,
                "disabledNew" => "true",
                "defaultValue" => ""
            ],
            "CaseIDDetail" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "autogenerated" => true,
                "defaultOverride" => true,
                "defaultValue" => "(new)"
            ],
            "Subject" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Created" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "Message" => [
                "dbType" => "varchar(999)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ScreenShotURL" => [
                "dbType" => "varchar(120)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "CaseId" => "Case ID",
        "Subject" => "Subject",
        "Created" => "Created",
        "Message" => "Message",
        "ScreenShotURL" => "ScreenShot URL",
        "CaseIDDetail" => "Case ID Detail"
    ];
}
?>
