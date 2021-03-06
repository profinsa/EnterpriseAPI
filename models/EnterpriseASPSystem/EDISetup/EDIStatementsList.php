<?php
/*
  Name of Page: EDI Statements

  Method: Model for grid and detail sceens. It provides data from database and default values, column names and categories

  Date created: 19/02/2019 Nikita Zaharov

  Use: this model used by gridView for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by controllers
  used as model by 

  Calls:
  MySql Database

  Last Modified: 19/02/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
class EDIStatementsList extends gridDataSource{
    public $tableName = "edistatements";
    public $dashboardTitle ="EDI Statements";
    public $breadCrumbTitle ="EDI Statements";
	public $idField ="BankID";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","BankID", "BankTransactionID"];
    public $gridFields = [
        "BankID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "BankTransactionID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TransactionDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "TransactionType" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TransactionAmount" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CurrencyID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
    ];

    public $editCategories = [
        "Main" => [
            "BankID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => true
            ],
            "BankTransactionID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => true
            ],
            "TransactionDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "TransactionType" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionDescription" => [
                "dbType" => "varchar(120)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionReference" => [
                "dbType" => "varchar(120)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "dataProvider" => "getCurrencyTypes",
                "defaultValue" => ""
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionCodeA" => [
                "dbType" => "varchar(1)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionCodeB" => [
                "dbType" => "varchar(1)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionCodeC" => [
                "dbType" => "varchar(1)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BeginningBalance" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EndingBalance" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DebitCredit" => [
                "dbType" => "varchar(1)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Cleared" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Reconciled" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "RelatedDocumentNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Notes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "BankID" => "Bank ID",
        "BankTransactionID" => "Bank Transaction ID",
        "SystemDate" => "System Date",
        "TransactionDate" => "Transaction Date",
        "TransactionType" => "Transaction Type",
        "TransactionAccount" => "Transaction Account",
        "TransactionDescription" => "Transaction Description",
        "TransactionReference" => "Transaction Reference",
        "TransactionAmount" => "Transaction Amount",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "TransactionCodeA" => "Transaction Code A",
        "TransactionCodeB" => "Transaction Code B",
        "TransactionCodeC" => "Transaction Code C",
        "BeginningBalance" => "Beginning Balance",
        "EndingBalance" => "Ending Balance",
        "DebitCredit" => "Debit Credit",
        "Cleared" => "Cleared",
        "Reconciled" => "Reconciled",
        "RelatedDocumentNumber" => "Related Document Number",
        "Notes" => "Notes"
    ];
}
?>
