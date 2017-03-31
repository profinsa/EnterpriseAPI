<?php
namespace App\Models;
require __DIR__ . "/../../../Models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "bankreconciliation";
    public $dashboardTitle ="Bank Reconciliation";
    public $breadCrumbTitle ="Bank Reconciliation";
    public $idField ="BankID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","BankID"];
    public $gridFields = [
        "BankID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "BankRecStartDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "BankRecEndDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "GLBankAccount" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
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
            "BankID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "BankRecStartDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "BankRecEndDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
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
            "GLBankAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "BankRecEndingBalance" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankRecServiceCharge" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
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
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAdjustmentAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "BankRecNotes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Credits" => [
            "BankID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ]
        ],
        "Debits" => [
            "BankID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "BankID" => "Bank ID",
        "BankRecStartDate" => "Start Date",
        "BankRecEndDate" => "End Date",
        "GLBankAccount" => "GL Bank Account",
        "BankRecEndingBalance" => "Balance",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "BankRecServiceCharge" => "Service Charge",
        "GLServiceChargeAccount" => "GL Service Charge Account",
        "BankRecIntrest" => "Bank RecI ntrest",
        "GLInterestAccount" => "GL Interest Account",
        "BankRecOtherCharges" => "Other Charges",
        "GLOtherChargesAccount" => "GL Other Charges Account",
        "BankRecAdjustment" => "Adjustment",
        "GLAdjustmentAccount" => "GL Adjustment Account",
        "BankRecNotes" => "Notes",
        "Signature" => "Signature",
        "SignaturePassword" => "SignaturePassword",
        "SupervisorSignature" => "SupervisorSignature",
        "SupervisorPassword" => "SupervisorPassword",
        "ManagerSignature" => "ManagerSignature",
        "ManagerPassword" => "ManagerPassword"
    ];
}
?>
