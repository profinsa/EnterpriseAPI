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
DB

Last Modified: 23.02.2016
Last Modified by: Nikita Zaharov
*/

namespace App\Models;

require __DIR__ . "/../../Models/gridDataSource.php";
use Session;

class gridData extends gridDataSource{
    protected $tableName = "bankaccounts";
    //fields to render in grid
    protected $gridFields = [
        "BankID",
        "BankAccountNumber",
        "BankName",
        "BankPhone",
        "GLBankAccount"
    ];

    public $dashboardTitle = "Bank Accounts";
    public $breadCrumbTitle = "Bank Accounts";
    public $idField = "BankAccountNumber";
    
    //categories which contains table columns, used by view for render tabs and them content
    public $editCategories = [
        "Main" => [
            "BankID" => [
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "BankAccountNumber" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankName" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankAddress1" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankAddress2" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankCity" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankState" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankZip" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankCountry" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankPhone" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankFax" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankContactName" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankEmail" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankWebsite" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SwiftCode" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RoutingCode" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyID" => [
                "inputType" => "dropdown",
                "defaultValue" => "USD",
                "dataProvider" => "getCurrencyTypes"
            ],
            "CurrencyExchangeRate" => [
                "inputType" => "text",
                "defaultValue" => "1.00"
            ],
            "NextCheckNumber" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NextDepositNumber" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "UnpostedDeposits" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBankAccount" => [
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getAccounts"
            ],
            "Notes" => [
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