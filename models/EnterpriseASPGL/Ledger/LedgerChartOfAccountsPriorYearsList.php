<?php
require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    public $tableName = "ledgerchartofaccountsprioryears";
    public $dashboardTitle ="Prior Fiscal Year Balances";
    public $breadCrumbTitle ="Prior Fiscal Year Balances";
    public $idField ="GLAccountNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","GLAccountNumber","GLFiscalYear"];
    public $gridFields = [
        "GLAccountNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLFiscalYear" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "GLBudgetID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLAccountName" => [
            "dbType" => "varchar(30)",
            "inputType" => "text"
        ],
        "GLAccountDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "GLAccountUse" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "GLAccountType" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLBalanceType" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLAccountBalance" => [
            "dbType" => "decimal(19,4)",
            "addFields" => "CurrencyID",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "GLAccountNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "GLFiscalYear" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "GLBudgetID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getLedgerBudgetId",
                "defaultValue" => ""
            ],
            "GLAccountName" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountUse" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountType" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getLedgerAccountTypes",
                "defaultValue" => ""
            ],
            "GLBalanceType" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getLedgerBalanceTypes",
                "defaultValue" => ""
            ],
            "GLReportingAccount" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GLReportLevel" => [
                "dbType" => "smallint(6)",
                "inputType" => "text",
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
            "GLAccountBalance" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountBeginningBalance" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "GLOtherNotes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Periods" => [
            "GLPriorYearBeginningBalance" => [
                "dbType" => "decimal(19,4)",
                "addFields" => "CurrencyID",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriorYearPeriod1" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriorYearPeriod2" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriorYearPeriod3" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriorYearPeriod4" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriortYearPeriod5" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriorYearPeriod6" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriorYearPeriod7" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriorYearPeriod8" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriorYearPeriod9" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriortYearPeriod10" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriorYearPeriod11" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriorYearPeriod12" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriorYearPeriod13" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLPriorYearPeriod14" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "GLAccountNumber" => "GL Account Number",
        "GLFiscalYear" => "GL Fiscal Year",
        "GLBudgetID" => "GL Budget ID",
        "GLAccountName" => "GL Account Name",
        "GLAccountDescription" => "GL Account Description",
        "GLAccountUse" => "GL Account Use",
        "GLAccountType" => "GL Account Type",
        "GLBalanceType" => "GL Balance Type",
        "GLReportLevel" => "GL Report Level",
        "GLReportingAccount" => "GL Reporting Account",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "GLAccountBalance" => "GL Account Balance",
        "GLAccountBeginningBalance" => "GL Account Beginning Balance",
        "GLOtherNotes" => "GL Other Notes",
        "GLPriorYearBeginningBalance" => "Beginning Balance",
        "GLPriorYearPeriod1" => "Period 1",
        "GLPriorYearPeriod2" => "Period 2",
        "GLPriorYearPeriod3" => "Period 3",
        "GLPriorYearPeriod4" => "Period 4",
        "GLPriortYearPeriod5" => "Period 5",
        "GLPriorYearPeriod6" => "Period 6",
        "GLPriorYearPeriod7" => "Period 7",
        "GLPriorYearPeriod8" => "Period 8",
        "GLPriorYearPeriod9" => "Period 9",
        "GLPriortYearPeriod10" => "Period 10",
        "GLPriorYearPeriod11" => "Period 11",
        "GLPriorYearPeriod12" => "Period 12",
        "GLPriorYearPeriod13" => "Period 13",
        "GLPriorYearPeriod14" => "Period 14"
    ];
}
