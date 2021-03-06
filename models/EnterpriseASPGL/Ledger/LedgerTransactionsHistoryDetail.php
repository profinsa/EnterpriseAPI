<?php
require "./models/subgridDataSource.php";

class LedgerTransactionsHistoryDetail extends subgridDataSource{
    public $tableName = "ledgertransactionsdetailhistory";
    public $dashboardTitle ="Ledger Transactions History Detail";
    public $breadCrumbTitle ="Ledger Transactions History Detail";
    public $idField ="GLTransactionNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","GLTransactionNumber","GLTransactionNumberDetail"];
    public $modes = ["grid", "view"];
    public $gridFields = [
        "GLTransactionAccount" => [
            "dbType" => "varchar(36)",
            "inputType" => "dropdown",
            "dataProvider" => "getAccounts",
            "defaultValue" => ""
        ],
        "GLDebitAmount" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "defaultValue" => "",
            "addFields" => "CurrencyID",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ],
        "GLCreditAmount" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "defaultValue" => "",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ],
        "ProjectID" => [
            "dbType" => "varchar(36)",
            "inputType" => "dropdown",
            "dataProvider" => "getProjects",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "GLTransactionAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLDebitAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => "",
                "addFields" => "CurrencyID",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
            ],
            "GLCreditAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
            ],
            "ProjectID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "GLTransactionNumber" => "Transaction Number",
        "GLTransactionNumberDelail" => "Transaction Number Detail",
        "GLTransactionAccount" => "Account",
        "GLTransactionTypeID" => "Type",
        "CurrencyID" => "Currency",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "GLDebitAmount" => "Debit Amount",
        "GLCreditAmount" => "Credit Amount",
        "ProjectID" => "Project ID"
    ];
}
?>
