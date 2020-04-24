<?php
/*
  Name of Page: CustomerContactLogList model
   
  Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerContactLogList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/CustomerContactLogList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerContactLogList.php
  used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerContactLogList.php
   
  Calls:
  MySql Database
   
  Last Modified: 08/14/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class CustomerContactLogList extends gridDataSource{
    public $tableName = "customercontactlog";
    public $dashboardTitle ="Customer Contact Log";
    public $breadCrumbTitle ="Customer Contact Log";
    public $idField ="CustomerID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ContactID","ContactLogID"];
    public $gridFields = [
        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "ContactID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ContactLogID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ContactDate" => [
            "dbType" => "timestamp",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "ContactDesctiption" => [
            "dbType" => "varchar(255)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactLogID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ContactDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ContactCallStartTime" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ContactCallEndTime" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ContactDesctiption" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "CustomerID" => "Customer ID",
        "ContactID" => "Contact ID",
        "ContactLogID" => "Contact Log ID",
        "ContactDate" => "Contact Date",
        "ContactDesctiption" => "Contact Desctiption",
        "ContactCallStartTime" => "Contact Call Start Time",
        "ContactCallEndTime" => "Contact Call End Time"
    ];
}
?>
