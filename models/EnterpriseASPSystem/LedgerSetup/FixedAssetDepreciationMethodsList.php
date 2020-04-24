<?php

/*
Name of Page: FixedAssetDepreciationMethodsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\FixedAssetDepreciationMethodsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/FixedAssetDepreciationMethodsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\FixedAssetDepreciationMethodsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\FixedAssetDepreciationMethodsList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";

class FixedAssetDepreciationMethodsList extends gridDataSource{
    public $tableName = "fixedassetdepreciationmethods";
    public $dashboardTitle ="Fixed Asset Depreciation Methods";
    public $breadCrumbTitle ="Fixed Asset Depreciation Methods";
    public $idField ="AssetDepreciationMethodID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","AssetDepreciationMethodID"];
    public $gridFields = [
        "AssetDepreciationMethodID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "DepreciationMethodDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "DepreciationFormula" => [
            "dbType" => "varchar(250)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "AssetDepreciationMethodID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disableEdit" => true
            ],
            "DepreciationMethodDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepreciationFormula" => [
                "dbType" => "varchar(250)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "AssetDepreciationMethodID" => "Asset Depreciation Method ID",
        "DepreciationMethodDescription" => "Depreciation Method Description",
        "DepreciationFormula" => "Depreciation Formula"
    ];
}
?>
