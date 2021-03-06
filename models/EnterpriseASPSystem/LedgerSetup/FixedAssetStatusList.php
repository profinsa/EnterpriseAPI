<?php

/*
Name of Page: FixedAssetStatusList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\FixedAssetStatusList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/FixedAssetStatusList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\FixedAssetStatusList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\FixedAssetStatusList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";

class FixedAssetStatusList extends gridDataSource{
    public $tableName = "fixedassetstatus";
    public $dashboardTitle ="Fixed Asset Status";
    public $breadCrumbTitle ="Fixed Asset Status";
    public $idField ="AssetStatusID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","AssetStatusID"];
    public $gridFields = [
        "AssetStatusID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "AssetStatusDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "AssetStatusID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disableEdit" => true
            ],
            "AssetStatusDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "AssetStatusID" => "Asset Status ID",
        "AssetStatusDescription" => "Asset Status Description"
    ];
}
?>
