<?php
require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "ledgertransactions";
    public $dashboardTitle ="Ledger Transactions";
    public $breadCrumbTitle ="Ledger Transactions";
    public $idField ="GLTransactionNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","GLTransactionNumber"];
    public $modes = ["grid", "view", "edit", "new"];
    protected $gridConditions = "GLTransactionPostedYN='0'";
    public $gridFields = [
        "GLTransactionNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLTransactionTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLTransactionDate" => [
            "dbType" => "timestamp",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "GLTransactionDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "CurrencyID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text"
        ],
        "GLTransactionAmount" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ],
        "GLTransactionBalance" => [
            "dbType" => "decimal(19,4)",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat",
            "inputType" => "text"
        ],
        "GLTransactionPostedYN" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "GLTransactionNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLTransactionTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getLedgerTransactionTypes",
                "defaultValue" => ""
            ],
            "GLTransactionDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "GLTransactionDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLTransactionReference" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLTransactionAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
            ],
            "GLTransactionAmountUndistributed" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
            ],
            "GLTransactionPostedYN" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GLTransactionSource" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLTransactionSystemGenerated" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GLTransactionRecurringYN" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Memorize" => [
                "dbType" => "tinyint(1)",
                "inputType" => "text",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ]
    ];
    public $columnNames = [
        "GLTransactionNumber" => "Transaction Number",
        "GLTransactionTypeID" => "Type",
        "GLTransactionDate" => "Date",
        "GLTransactionDescription" => "GL Transaction Description",
        "CurrencyID" => "Currency",
        "GLTransactionAmount" => "Amount",
        "GLTransactionBalance" => "Balance",
        "GLTransactionPostedYN" => "Posted YN",
        "SystemDate" => "System Date",
        "GLTransactionReference" => "GL Transaction Reference",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "GLTransactionAmountUndistributed" => "GL Transaction Amount Undistributed",
        "GLTransactionSource" => "GL Transaction Source",
        "GLTransactionSystemGenerated" => "GL Transaction System Generated",
        "GLTransactionRecurringYN" => "GL Transaction Recurring YN",
        "Reversal" => "Reversal",
        "Approved" => "Approved",
        "ApprovedBy" => "ApprovedBy",
        "ApprovedDate" => "Approved Date",
        "EnteredBy" => "EnteredBy",
        "BatchControlNumber" => "Batch Control Number",
        "BatchControlTotal" => "Batch Control Total",
        "Signature" => "Signature",
        "SignaturePassword" => "Signature Password",
        "SupervisorSignature" => "Supervisor Signature",
        "SupervisorPassword" => "Supervisor Password",
        "ManagerSignature" => "Manager Signature",
        "ManagerPassword" => "Manager Password",
        "Memorize" => "Memorize"
    ];
}
?>
