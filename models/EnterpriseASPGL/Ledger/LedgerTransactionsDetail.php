<?php
require "./models/subgridDataSource.php";

class gridData extends subgridDataSource{
    protected $tableName = "ledgertransactionsdetail";
    public $dashboardTitle ="Ledger Transactions Detail";
    public $breadCrumbTitle ="Ledger Transactions Detail";
    public $idField ="GLTransactionNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","GLTransactionNumber","GLTransactionNumberDetail"];
    public $modes = ["grid", "view", "edit", "new", "delete"];
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
        ],
        "GLControlNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "dropdown",
            "dataProvider" => "getGLControlNumbers",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "GLTransactionNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => ""
            ],
            "GLTransactionNumberDetail" => [
                "dbType" => "bigint(20)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultOverride" => "true",
                "autogenerated" => true,
                "defaultValue" => "(new)"
            ],
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
            ],
            "GLControlNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getGLControlNumbers",
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
        "ProjectID" => "Project ID",
        "GLControlNumber" => "Control Number"
    ];
}
?>
