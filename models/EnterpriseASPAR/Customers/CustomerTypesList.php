<?php
/*
  Name of Page: CustomerTypesList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Customers\CustomerTypesList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/CustomerTypesList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Customers\CustomerTypesList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Customers\CustomerTypesList.php
   
  Calls:
  MySql Database
   
  Last Modified: 08/14/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class CustomerTypesList extends gridDataSource{
    public $tableName = "customertypes";
    public $dashboardTitle ="Customer Types";
    public $breadCrumbTitle ="Customer Types";
    public $idField ="CustomerTypeID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerTypeID"];
    public $gridFields = [
        "CustomerTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "CustomerTypeDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [

            "CustomerTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerTypeDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "CustomerTypeID" => "Customer Type ID",
        "CustomerTypeDescription" => "Customer Type Description"];
}
?>
