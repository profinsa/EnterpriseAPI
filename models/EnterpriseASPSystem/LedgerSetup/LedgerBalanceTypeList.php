<?php

/*
Name of Page: LedgerBalanceTypeList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\LedgerBalanceTypeList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/LedgerBalanceTypeList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\LedgerBalanceTypeList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\LedgerBalanceTypeList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    public $tableName = "ledgerbalancetype";
    public $dashboardTitle ="LedgerBalanceType";
    public $breadCrumbTitle ="LedgerBalanceType";
    public $idField ="GLBalanceType";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","GLBalanceType"];
    public $gridFields = [
        "GLBalanceType" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLBalanceTypeDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "GLBalanceType" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBalanceTypeDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "GLBalanceType" => "GL Balance Type",
        "GLBalanceTypeDescription" => "GL Balance Type Description"
    ];
}
?>
