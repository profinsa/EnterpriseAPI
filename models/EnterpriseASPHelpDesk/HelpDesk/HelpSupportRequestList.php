<?php
/*
Name of Page: HelpSupportRequestList
 
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
    public $tableName = "helpsupportrequest";
    public $dashboardTitle ="helpsupportrequest";
    public $breadCrumbTitle ="helpsupportrequest";
    public $idField ="CaseID";
    public $idFields = ["CompanyID", "DivisionID", "DepartmentID", "CaseID"];
    public $gridFields = [
        "CaseId" => [
            "dbType" => "int(11)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerId" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ContactId" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ProductId" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportManager" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportAssigned" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "SupportAssignedTo" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportRequestMethod" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportStatus" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportPriority" => [
            "dbType" => "tinyint(3) unsigned",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportType" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportVersion" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "SupportQuestion" => [
            "dbType" => "varchar(255)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportKeywords" => [
            "dbType" => "varchar(120)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportDescription" => [
            "dbType" => "varchar(999)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportScreenShotURL" => [
            "dbType" => "varchar(120)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportResolution" => [
            "dbType" => "varchar(999)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportResolutionDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "SupportTimeSpentFixing" => [
            "dbType" => "float",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SuportNotesPrivate" => [
            "dbType" => "varchar(255)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "SupportApproved" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "SupportApprovedBy" => [
            "dbType" => "varchar(26)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "CaseId" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerId" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactId" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProductId" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportManager" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportAssigned" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SupportAssignedTo" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportRequestMethod" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportStatus" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportPriority" => [
                "dbType" => "tinyint(3) unsigned",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportType" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportVersion" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "SupportQuestion" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportKeywords" => [
                "dbType" => "varchar(120)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportDescription" => [
                "dbType" => "varchar(999)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportScreenShotURL" => [
                "dbType" => "varchar(120)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportResolution" => [
                "dbType" => "varchar(999)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportResolutionDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "SupportTimeSpentFixing" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SuportNotesPrivate" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupportApproved" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SupportApprovedBy" => [
                "dbType" => "varchar(26)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "CaseId" => "CaseId",
        "CustomerId" => "CustomerId",
        "ContactId" => "ContactId",
        "ProductId" => "ProductId",
        "SupportManager" => "SupportManager",
        "SupportAssigned" => "SupportAssigned",
        "SupportAssignedTo" => "SupportAssignedTo",
        "SupportRequestMethod" => "SupportRequestMethod",
        "SupportStatus" => "SupportStatus",
        "SupportPriority" => "SupportPriority",
        "SupportType" => "SupportType",
        "SupportVersion" => "SupportVersion",
        "SupportDate" => "SupportDate",
        "SupportQuestion" => "SupportQuestion",
        "SupportKeywords" => "SupportKeywords",
        "SupportDescription" => "SupportDescription",
        "SupportScreenShotURL" => "SupportScreenShotURL",
        "SupportResolution" => "SupportResolution",
        "SupportResolutionDate" => "SupportResolutionDate",
        "SupportTimeSpentFixing" => "SupportTimeSpentFixing",
        "SuportNotesPrivate" => "SuportNotesPrivate",
        "SupportApproved" => "SupportApproved",
        "SupportApprovedBy" => "SupportApprovedBy"
    ];
}
?>
