<?php

/*
Name of Page: BankTransactionTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\BankTransactionTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/BankTransactionTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\BankTransactionTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\BankTransactionTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";

class BankTransactionTypesList extends gridDataSource{
    public $tableName = "banktransactiontypes";
    public $dashboardTitle ="Bank Transaction Types";
    public $breadCrumbTitle ="Bank Transaction Types";
    public $idField ="BankTransactionTypeID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","BankTransactionTypeID"];
    public $gridFields = [
        "BankTransactionTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "BankTransactionTypeDesc" => [
            "dbType" => "varchar(80)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "BankTransactionTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disableEdit" => true
            ],
            "BankTransactionTypeDesc" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "BankTransactionTypeID" => "Bank Transaction Type ID",
        "BankTransactionTypeDesc" => "Bank Transaction Type Description"
    ];
}
?>
