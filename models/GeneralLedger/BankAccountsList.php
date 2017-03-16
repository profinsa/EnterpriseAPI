<?php
/*
Name of Page: bankAccounts model

Method: Model for GeneralLedger/banckAccounts. It provides data from database and default values, column names and categories

Date created: Nikita Zaharov, 17.02.2016

Use: this model used by views/GeneralLedger/bankAccounts.php for:
- as dictionary for view during building interface(tabs and them names, fields and them names etc, column name and translationid corresponding)
- for loading data from tables, updating, inserting and deleting

Input parameters:
$db: database instance
methods has own parameters

Output parameters:
- dictionaries as public properties
- methods has own output

Called from:
created and used for ajax requests by controllers/GeneralLedger/banckAccounts.php
used as model by views/GeneralLedger/backAccounts.php

Calls:
sql

Last Modified: 16.03.2016
Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "bankaccounts";
    //fields to render in grid
    public $gridFields = [
        "BankID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "BankAccountNumber" => [
            "dbType" => "varchar(30)",
            "inputType" => "text"
        ],
        "BankName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "BankPhone" => [
            "dbType" => "varchar(30)",
            "inputType" => "text"
        ],
        "GLBankAccount" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ]
    ];

    public $dashboardTitle = "Bank Accounts";
    public $breadCrumbTitle = "Bank Accounts";
    public $idField = "BankAccountNumber";
    public $idFields = ["CompanyID", "DivisionID", "DepartmentID", "BankAccountNumber"];
    
    //categories which contains table columns, used by view for render tabs and them content
    public $editCategories = [
        "Main" => [
            "BankID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "BankAccountNumber" => [
               "dbType" => "varchar(30)",
               "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankAddress1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankAddress2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankCity" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankState" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankZip" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankCountry" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankPhone" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankFax" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankContactName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankEmail" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankWebsite" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SwiftCode" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RoutingCode" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "defaultValue" => "USD",
                "dataProvider" => "getCurrencyTypes"
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => "1.00"
            ],
            "NextCheckNumber" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NextDepositNumber" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "UnpostedDeposits" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBankAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getAccounts"
            ],
            "Notes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
    ];

    //table column to translation/ObjID
    public $columnNames = [
        "BankID" => "Bank ID",
        "BankAccountNumber" => "Bank Account Number",
        "BankName" => "Bank Name",
        "BankAddress1" => "Bank Address 1",
        "BankAddress2" => "Bank Address 2",
        "BankCity" => "Bank City",
        "BankState" => "Bank State",
        "BankZip" => "Bank Zip",
        "BankCountry" => "Bank Country",
        "BankPhone" => "Bank Phone",
        "BankFax" => "Bank Fax",
        "BankContactName" => "Bank Contact Name",
        "BankEmail" => "Bank Email",
        "BankWebsite" => "Bank Website",
        "SwiftCode" => "Swift Code",
        "RoutingCode" => "Routing Code",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "NextCheckNumber" => "Next Check Number",
        "NextDepositNumber" => "Next Deposit Number",
        "UnpostedDeposits" => "Unposted Deposits",
        "GLBankAccount" => "GL Bank Account",
        "Notes" => "Notes"
    ];
}
?>