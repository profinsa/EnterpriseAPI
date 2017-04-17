<?php

/*
Name of Page: LedgerYearCloseDetail model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\LedgerYearCloseDetail.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/LedgerYearCloseDetail for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\LedgerYearCloseDetail.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\LedgerSetup\LedgerYearCloseDetail.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";

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
        "FiscalStartDate" => "Fiscal Start Date",
        "FiscalEndDate" => "Fiscal End Date",
        "CurrentFiscalYear" => "Current Fiscal Year",
        "CurrentPeriod" => "Current Period",
        "Period1Date" => "Period 1 Date",
        "Period2Date" => "Period 2 Date",
        "Period3Date" => "Period 3 Date",
        "Period4Date" => "Period 4 Date",
        "Period5Date" => "Period 5 Date",
        "Period6Date" => "Period 6 Date",
        "Period7Date" => "Period 7 Date",
        "Period8Date" => "Period 8 Date",
        "Period9Date" => "Period 9 Date",
        "Period10Date" => "Period 10 Date",
        "Period11Date" => "Period 11 Date",
        "Period12Date" => "Period 12 Date",
        "Period13Date" => "Period 13 Date",
        "Period14Date" => "Period 14 Date",

        "Period1Closed" => "Period 1 Closed",
        "Period2Closed" => "Period 2 Closed",
        "Period3Closed" => "Period 3 Closed",
        "Period4Closed" => "Period 4 Closed",
        "Period5Closed" => "Period 5 Closed",
        "Period6Closed" => "Period 6 Closed",
        "Period7Closed" => "Period 7 Closed",
        "Period8Closed" => "Period 8 Closed",
        "Period9Closed" => "Period 9 Closed",
        "Period10Closed" => "Period 10 Closed",
        "Period11Closed" => "Period 11 Closed",
        "Period12Closed" => "Period 12 Closed",
        "Period13Closed" => "Period 13 Closed",
        "Period14Closed" => "Period 14 Closed"
    ];

    public function CloseYear(){
        $user = $_SESSION["user"];

        $GLOBALS["capsule"]::statement("CALL Ledger_YearEndClose('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "', @SWP_RET_VALUE)");

        $result = $GLOBALS["capsule"]::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
        if($result[0]->SWP_RET_VALUE > -1)
            echo $result[0]->SWP_RET_VALUE;
        else {
            http_response_code(400);
            echo $result[0]->SWP_RET_VALUE;
        }
    }
}
?>
