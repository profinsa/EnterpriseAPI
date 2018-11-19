<?php
/*
  Name of Page: LeadTypeList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadTypeList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/LeadTypeList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadTypeList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadTypeList.php
   
  Calls:
  MySql Database
   
  Last Modified: 19/11/2018
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    public $tableName = "leadtype";
    public $dashboardTitle ="Lead Type";
    public $breadCrumbTitle ="Lead Type";
    public $idField ="LeadTypeID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","LeadTypeID"];
    public $gridFields = [
        "LeadTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "LeadTypeDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "LeadTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadTypeDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "LeadTypeID" => "Lead Type ID",
        "LeadTypeDescription" => "Lead Type Description"
    ];
}
?>
