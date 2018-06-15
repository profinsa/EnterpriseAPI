<?php
require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    public $tableName = "ledgerchartofaccountsbudgets";
    public $dashboardTitle ="Budgets";
    public $breadCrumbTitle ="Budgets";
    public $idField ="GLBudgetID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","GLBudgetID","GLAccountNumber"];
    public $gridFields = [
        "GLBudgetID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLAccountNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLBudgetNotes" => [
            "dbType" => "varchar(255)",
            "inputType" => "text"
        ],
        "GLBudgetActive" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "GLFiscalYear" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "GLBudgetBeginningBalance" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "GLBudgetCurrentBalance" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "GLBudgetID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "GLBudgetNotes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetActive" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GLFiscalYear" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "GLBudgetBeginningBalance" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetCurrentBalance" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Periods" => [
            "GLBudgetPeriod1" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod1Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod1Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod2" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod2Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod2Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod3" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod3Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod3Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod4" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod4Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod4Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod5" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod5Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod5Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod6" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod6Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod6Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod7" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod7Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod7Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod8" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod8Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod8Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod9" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod9Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod9Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod10" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod10Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod10Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod11" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod11Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod11Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod12" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod12Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod12Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod13" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod13Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod13Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod14" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod14Variance" => [
                "dbType" => "float",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBudgetPeriod14Reason" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "GLBudgetID" => "GL Budget ID",
        "GLAccountNumber" => "GL Account Number",
        "GLAccountName" => "GL Account Name",
        "GLBudgetNotes" => "Notes",
        "GLFiscalYear" => "GL Fiscal Year",
        "GLBudgetBeginningBalance" => "Beginning Balance",
        "GLBudgetCurrentBalance" => "Current Balance",
        "GLBudgetActive" => "Active",
        "GLBudgetPeriod1" => "Period 1",
        "GLBudgetPeriod1Variance" => "Period 1 Variance",
        "GLBudgetPeriod1Reason" => "Period1 Reason",
        "GLBudgetPeriod2" => "Period 2",
        "GLBudgetPeriod2Variance" => "Period2 Variance",
        "GLBudgetPeriod2Reason" => "Period 2 Reason",
        "GLBudgetPeriod3" => "Period 3",
        "GLBudgetPeriod3Variance" => "Period 3 Variance",
        "GLBudgetPeriod3Reason" => "Period 3 Reason",
        "GLBudgetPeriod4" => "Period 4",
        "GLBudgetPeriod4Variance" => "Period 4 Variance",
        "GLBudgetPeriod4Reason" => "Period 4 Reason",
        "GLBudgetPeriod5" => "Period 5",
        "GLBudgetPeriod5Variance" => "Period 5 Variance",
        "GLBudgetPeriod5Reason" => "Period 5 Reason",
        "GLBudgetPeriod6" => "Period 6",
        "GLBudgetPeriod6Variance" => "Period 6 Variance",
        "GLBudgetPeriod6Reason" => "Period6 Reason",
        "GLBudgetPeriod7" => "Period 7",
        "GLBudgetPeriod7Variance" => "Period 7 Variance",
        "GLBudgetPeriod7Reason" => "Period 7 Reason",
        "GLBudgetPeriod8" => "Period 8",
        "GLBudgetPeriod8Variance" => "Period 8 Variance",
        "GLBudgetPeriod8Reason" => "Period 8 Reason",
        "GLBudgetPeriod9" => "Period 9",
        "GLBudgetPeriod9Variance" => "Period 9 Variance",
        "GLBudgetPeriod9Reason" => "Period 9 Reason",
        "GLBudgetPeriod10" => "Period 10",
        "GLBudgetPeriod10Variance" => "Period 10 Variance",
        "GLBudgetPeriod10Reason" => "Period 10 Reason",
        "GLBudgetPeriod11" => "Period 11",
        "GLBudgetPeriod11Variance" => "Period 11 Variance",
        "GLBudgetPeriod11Reason" => "Period 11 Reason",
        "GLBudgetPeriod12" => "Period 12",
        "GLBudgetPeriod12Variance" => "Period12 Variance",
        "GLBudgetPeriod12Reason" => "Period 12 Reason",
        "GLBudgetPeriod13" => "Period 13",
        "GLBudgetPeriod13Variance" => "Period 13 Variance",
        "GLBudgetPeriod13Reason" => "Period 13 Reason",
        "GLBudgetPeriod14" => "Period 14",
        "GLBudgetPeriod14Variance" => "Period 14 Variance",
        "GLBudgetPeriod14Reason" => "Period 14 Reason"
    ];
}?>
