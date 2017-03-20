<?php
/*
Name of Page: bankTransactions model

Method: Model for GeneralLedger/banckAccounts. It provides data from database and default values, column names and categories

Date created: Nikita Zaharov, 17.02.2016

Use: this model used by views/GeneralLedger/bankTransactions.php for:
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

Last Modified: 15.03.2016
Last Modified by: Nikita Zaharov
*/

namespace App\Models;

use Illuminate\Support\Facades\DB;
require __DIR__ . "/../../../Models/gridDataSource.php";
use Session;

class gridData extends gridDataSource{
    protected $tableName = "banktransactions";
    //fields to render in grid
    public $gridFields = [
        "BankTransactionID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "BankDocumentNumber" => [
            "dbType" => "varchar(30)",
            "inputType" => "text"
        ],
        "TransactionType" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "TransactionDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "TransactionAmount" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text",
            "addFields" => "CurrencyID",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ],
        "Posted" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ],
        "Cleared" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ]
    ];

    public $dashboardTitle = "Bank Transactions";
    public $breadCrumbTitle = "Bank Transactions";
    public $idField = "BankTransactionID";
    public $idFields = ["CompanyID", "DivisionID", "DepartmentID", "BankTransactionID"];
    
    //categories which contains table columns, used by view for render tabs and them content
    public $editCategories = [
        "Main" => [
            "BankTransactionID" => [
                "dbType" => "varchar(36)",
                "disabledEdit" => true,
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankDocumentNumber" =>	[
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ], 
            "GLBankAccount1" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getAccounts"
            ],
            "GLBankAccount2" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getAccounts"
            ],
            "TransactionType" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getBankTransactionTypes"
            ],
            "TransactionDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => ""
            ],
            "CurrencyID" =>	[
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "defaultValue" => "USD",
                "dataProvider" => "getCurrencyTypes"
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => "1"
            ],
            "TransactionAmount" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
            ],
            "BeginningBalance" =>  [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],	
            "Reference" =>  [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],	 
            "Posted" =>  [
                "dbType" => "tinyint(1)",
                "disabledEdit" => true,
                "disabledNew" => true,
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],	
            "Cleared" =>  [
                "dbType" => "tinyint(1)",
                "disabledEdit" => true,
                "disabledNew" => true,
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],	
            "Notes" =>  [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];

    //table column to translation/ObjID
    public $columnNames = [
        "BankTransactionID" => "Transaction ID",
        "BankDocumentNumber" => "Bank Document Number", 	 
        "GLBankAccount1" => "Bank Account",
        "GLBankAccount2" => "Offset Account", 
        "TransactionType" => "Transaction Type", 
        "TransactionDate" => "Transaction Date",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate", 
        "TransactionAmount" => "Transaction Amount", 
        "BeginningBalance" => "Beginning Balance", 	
        "Reference" => "Reference", 	 
        "Posted" => "Posted", 	
        "Cleared" => "Cleared", 	
        "Notes" => "Notes" 
    ];

}
?>