<?php

/*
Name of Page: FixedAssetTypeList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\FixedAssetTypeList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/FixedAssetTypeList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\FixedAssetTypeList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\FixedAssetTypeList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";

class FixedAssetTypeList extends gridDataSource{
    public $tableName = "fixedassettype";
    public $dashboardTitle ="Fixed Asset Type";
    public $breadCrumbTitle ="Fixed Asset Type";
    public $idField ="AssetTypeID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","AssetTypeID"];
    public $gridFields = [
        "AssetTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "AssetTypeDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "AssetTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disableEdit" => true
            ],
            "AssetTypeDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "AssetTypeID" => "Asset Type ID",
        "AssetTypeDescription" => "Asset Type Description"
    ];
}
?>
