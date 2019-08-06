<?php
/*
Name of Page: HelpSupportRequestTypeList
 
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
 
Last Modified: 06/08/2019
Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "helpsupportrequesttype";
    public $dashboardTitle ="helpsupportrequesttype";
    public $breadCrumbTitle ="helpsupportrequesttype";
    public $idField ="SupportRequestType";
    public $idFields = ["CompanyID", "DivisionID", "DepartmentID", "SupportRequestType"];
    public $gridFields = [
        "SupportRequestType" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportRequestTypeDescription" => [
            "dbType" => "varchar(120)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "SupportRequestType" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportRequestTypeDescription" => [
                "dbType" => "varchar(120)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "SupportRequestType" => "SupportRequestType",
        "SupportRequestTypeDescription" => "SupportRequestTypeDescription"
    ];
}
?>
