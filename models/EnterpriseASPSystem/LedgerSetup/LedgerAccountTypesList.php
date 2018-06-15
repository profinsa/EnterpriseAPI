<?php

/*
Name of Page: LedgerAccountTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\LedgerAccountTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/LedgerAccountTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\LedgerAccountTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\LedgerAccountTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    public $tableName = "ledgeraccounttypes";
    public $dashboardTitle ="Ledger Account Types";
    public $breadCrumbTitle ="Ledger Account Types";
    public $idField ="GLAccountType";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","GLAccountType"];
    public $gridFields = [
        "GLAccountType" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "GLAccountType" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]];
    public $columnNames = [
        "GLAccountType" => "GL Account Type"
    ];
}?>
