<?php
require "./models/gridDataSource.php";

class BankReconciliationSummaryList extends gridDataSource{
    public $tableName = "bankreconciliationsummary";
    public $dashboardTitle ="Reconciliation Summary";
    public $breadCrumbTitle ="Reconciliation Summary";
    public $modes = ["grid", "view", "edit"];
    public $idField ="BankRecID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","BankRecID"];
    public $gridFields = [
        "BankRecID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLBankAccount" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "BankRecCutoffDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "BankRecEndingBalance" => [
            "dbType" => "decimal(19,4)",
            "addFields" => "CurrencyID",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "BankRecID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "GLBankAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "dataProvider" => "getCurrencyTypes",
                "defaultValue" => "USD"
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankRecCutoffDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "BankRecEndingBalance" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "BankRecServiceCharge" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "GLServiceChargeAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "BankRecIntrest" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "GLInterestAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "BankRecOtherCharges" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLOtherChargesAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "BankRecAdjustment" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAdjustmentAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "BankRecCreditTotal" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankRecDebitTotal" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankRecCreditOS" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankRecDebitOS" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "BankRecStartingBalance" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankRecBookBalance" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankRecDifference" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankRecEndingBookBalance" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankRecStartingBookBalance" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
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
        "BankRecID" => "Reconciliation ID",
        "GLBankAccount" => "GL Account",
        "BankRecCutoffDate" => "End Date",
        "BankRecEndingBalance" => "End Balance",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "BankRecServiceCharge" => "Service Charge",
        "GLServiceChargeAccount" => "GL Service Charge Account",
        "BankRecIntrest" => "Intrest",
        "GLInterestAccount" => "GL Interest Account",
        "BankRecAdjustment" => "Bank Rec Adjustment",
        "GLAdjustmentAccount" => "GL Adjustment Account",
        "BankRecOtherCharges" => "Other Charges",
        "GLOtherChargesAccount" => "GL Other Charges Account",
        "BankRecCreditTotal" => "Credit Total",
        "BankRecDebitTotal" => "Debit Total",
        "BankRecCreditOS" => "Credit OS",
        "BankRecDebitOS" => "Debit OS",
        "BankRecStartingBalance" => "Starting Balance",
        "BankRecBookBalance" => "Book Balance",
        "BankRecDifference" => "Difference",
        "BankRecEndingBookBalance" => "Ending Book Balance",
        "BankRecStartingBookBalance" => "Starting Book Balance",
        "Notes" => "Notes"
    ];
}?>
