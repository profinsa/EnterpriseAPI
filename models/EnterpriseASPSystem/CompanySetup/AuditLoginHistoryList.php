<?php
/*
  Name of Page: AuditLoginHistoryList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditLoginHistoryList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Nikita Zaharov
   
  Use: this model used by views/AuditLoginHistoryList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditLoginHistoryList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditLoginHistoryList.php
   
  Calls:
  MySql Database
   
  Last Modified: 01/29/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class AuditLoginHistoryList extends gridDataSource{
    public $tableName = "auditloginhistory";
    public $dashboardTitle ="Audit Logins History";
    public $breadCrumbTitle ="Audit Logins History";
    public $idField ="EmployeeID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","AuditID"];
    public $modes = ["grid", "view"];
    public $gridFields = [
        "EmployeeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "AuditID" => [
            "dbType" => "decimal(24,0)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "LoginDateTime" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "dateTimeFull"
        ],
        "MachineName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "IPAddress" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "LoginType" => [
            "dbType" => "int(11)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "EmployeeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AuditID" => [
                "dbType" => "decimal(24,0)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LoginDateTime" => [
                "dbType" => "datetime",
                "inputType" => "dateTimeFull",
                "defaultValue" => "now"
            ],
            "MachineName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "IPAddress" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LoginType" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "EmployeeID" => "Employee ID",
        "AuditID" => "Audit ID",
        "LoginDateTime" => "Login DateTime",
        "MachineName" => "Machine Name",
        "IPAddress" => "IP Address",
        "LoginType" => "Login Type"
    ];
}
?>
