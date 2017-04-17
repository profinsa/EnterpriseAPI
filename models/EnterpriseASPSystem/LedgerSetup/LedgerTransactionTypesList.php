<?php

/*
Name of Page: LedgerTransactionTypesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\LedgerTransactionTypesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/LedgerTransactionTypesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\LedgerTransactionTypesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\LedgerTransactionTypesList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "ledgertransactiontypes";
    public $dashboardTitle ="Ledger Transaction Types";
    public $breadCrumbTitle ="Ledger Transaction Types";
    public $idField ="TransactionTypeID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","TransactionTypeID"];
    public $gridFields = [
        "TransactionTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "TransactionTypeDescription" => [
            "dbType" => "varchar(80)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "TransactionTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionTypeDescription" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "TransactionTypeID" => "Transaction Type ID",
        "TransactionTypeDescription" => "Transaction Type Description"
    ];
}
?>
