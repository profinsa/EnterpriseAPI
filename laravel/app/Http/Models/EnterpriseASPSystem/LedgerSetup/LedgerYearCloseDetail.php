<?php
namespace App\Models;
require __DIR__ . "/../../../Models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "companies";
    public $dashboardTitle ="Year Close ";
    public $breadCrumbTitle ="Year Close ";
    public $idField ="undefined";
    public $idFields = ["CompanyID","DivisionID","DepartmentID"];
    public $modes = ["edit"];
    public $gridFields = [
        "FiscalStartDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "FiscalEndDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "CurrentFiscalYear" => [
            "dbType" => "smallint(6)",
            "inputType" => "text"
        ],
        "CurrentPeriod" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period1Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period2Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period3Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period4Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period5Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period6Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period7Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period8Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period9Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period10Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period11Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period12Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period13Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "Period14Date" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "FiscalStartDate" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "FiscalEndDate" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "CurrentFiscalYear" => [
                "dbType" => "smallint(6)",
                "inputType" => "text"
            ],
            "CurrentPeriod" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period1Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period1Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Period2Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period2Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Period3Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period3Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Period4Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period4Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Period5Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period5Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Period6Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period6Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Period7Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period7Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Period8Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period8Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Period9Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period9Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Period10Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period10Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Period11Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period11Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Period12Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period12Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Period13Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period13Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Period14Date" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "inputType" => "datetime"
            ],
            "Period14Closed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ]
    ];
    public $columnNames = [
        "FiscalStartDate" => "FiscalStartDate",
        "FiscalEndDate" => "FiscalEndDate",
        "CurrentFiscalYear" => "Current Fiscal Year",
        "CurrentPeriod" => "Current Period",
        "Period1Date" => "Period1 Date",
        "Period2Date" => "Period2 Date",
        "Period3Date" => "Period3 Date",
        "Period4Date" => "Period4 Date",
        "Period5Date" => "Period5 Date",
        "Period6Date" => "Period6 Date",
        "Period7Date" => "Period7 Date",
        "Period8Date" => "Period8 Date",
        "Period9Date" => "Period9 Date",
        "Period10Date" => "Period10 Date",
        "Period11Date" => "Period11 Date",
        "Period12Date" => "Period12 Date",
        "Period13Date" => "Period13 Date",
        "Period14Date" => "Period14 Date",

        "Period1Closed" => "Period1 Closed",
        "Period2Closed" => "Period2 Closed",
        "Period3Closed" => "Period3 Closed",
        "Period4Closed" => "Period4 Closed",
        "Period5Closed" => "Period5 Closed",
        "Period6Closed" => "Period6 Closed",
        "Period7Closed" => "Period7 Closed",
        "Period8Closed" => "Period8 Closed",
        "Period9Closed" => "Period9 Closed",
        "Period10Closed" => "Period10 Closed",
        "Period11Closed" => "Period11 Closed",
        "Period12Closed" => "Period12 Closed",
        "Period13Closed" => "Period13 Closed",
        "Period14Closed" => "Period14 Closed"
    ];
}
?>
