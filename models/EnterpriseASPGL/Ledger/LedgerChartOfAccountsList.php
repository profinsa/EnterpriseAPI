<?php
/*
Name of Page: chartOfAccounts model

Method: Model for GeneralLedger/chartOfAccounts. It provides data from database and default values, column names and categories

Date created: Nikita Zaharov, 13.02.2016

Use: this model used by views/GeneralLedger/chartOfAccounts.php for:
- as dictionary for view during building interface(tabs and them names, fields and them names etc, column name and translationid corresponding)
- for loading data from tables, updating, inserting and deleting

Input parameters:
$db: database instance
methods has own parameters

Output parameters:
- dictionaries as public properties
- methods has own output

Called from:
created and used for ajax requests by controllers/GeneralLedger/chartOfAccounts.php
used as model by views/GeneralLedger/chartOfAccounts.php

Calls:
sql

Last Modified: 16.03.2016
Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "ledgerchartofaccounts"; //table name which used for read and write fields
    //fields to render in grid
    public $gridFields = [ //field list for showing in grid mode(columns)
        "GLAccountNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLAccountCode" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLAccountName" => [
            "dbType" => "varchar(30)",
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
            "format" => "{0:n}",
            "inputType" => "text",
            "addFields" => "CurrencyID",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ]
    ];

    public $dashboardTitle = "Chart Of Accounts"; //title in dashboard
    public $breadCrumbTitle = "Chart Of Accounts"; //title in breadCrumb
    public $idField = "GLAccountNumber"; //fieldname in database on which is selecting(CompanyID, DevisionID, DepartmentID, GLAccountNumber)
    public $idFields = ["CompanyID", "DivisionID", "DepartmentID", "GLAccountNumber"];

    /*categories which contains table columns, used by view for render tabs and them content
      It's array, each item - category name(Main, Current etc)
      Each category is array from fields which will be showed on tab
      Each field can have:
      - fieldname: column in database
      - inputType: text, checkbox or dropdown -required
      - defaultValue - required
      - dataProvider - name of method which is called for filling falues of item to select(for dropdowns like CurrencyID)
        Method can be declared in class or in parent class
      - disableEdit: true Which mean disable editing this element(like id field) in edit mode - optional
      - disableNew: true Which mean disable editing this element(like id field) in new mode - optional
     */
    public $editCategories = [
        "Main" => [
            "GLAccountNumber" => [
                "dbType" => "varchar(36)",
                "disableEdit" => true,
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountCode" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getGLAccountGroups"
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
                "defaultValue" => "",
                "dataProvider" => "getGLAccountTypes"
            ],
            "CurrencyID" =>	[
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "defaultValue" => "USD",
                "dataProvider" => "getCurrencyTypes"
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => "1"
            ],
            "GLBalanceType" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getGLBalanceTypes"
            ],
            "GLAccountBalance" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
            ],
            "GLOtherNotes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]	
        ],
        "Current" => [
            "GLCurrentYearPeriod1" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => "0",
                "addFields" => "CurrencyID",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
            ],	 
            "GLCurrentYearPeriod2" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLCurrentYearPeriod3" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLCurrentYearPeriod4" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLCurrentYearPeriod5" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLCurrentYearPeriod6" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLCurrentYearPeriod7" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLCurrentYearPeriod8" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLCurrentYearPeriod9" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLCurrentYearPeriod10" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLCurrentYearPeriod11" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLCurrentYearPeriod12" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLCurrentYearPeriod13" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLCurrentYearPeriod14" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ]
        ],
        "Budget" => [
            "GLBudgetBeginningBalance" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "addFields" => "CurrencyID",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod1" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod2" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod3" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod4" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod5" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod6" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod7" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod8" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod9" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod10" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod11" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod12" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod13" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLBudgetPeriod14" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ]
        ],
        "History" => [
            "GLPriorYearBeginningBalance" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "addFields" => "CurrencyID",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLPriorYearPeriod1" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLPriorYearPeriod2" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLPriorYearPeriod3" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLPriorYearPeriod4" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLPriortYearPeriod5" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],//ERROR in sql, must be Prior
            "GLPriorYearPeriod6" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLPriorYearPeriod7" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLPriorYearPeriod8" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLPriorYearPeriod9" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLPriortYearPeriod10" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],//ERROR in sql, must be Prior	 
            "GLPriorYearPeriod11" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLPriorYearPeriod12" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLPriorYearPeriod13" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"

            ],
            "GLPriorYearPeriod14" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
            ]
        ]
    ];

    /* table column to translation/ObjID
       many columns not translated by them names. For that column must be converted to displayed title. This is table contains column names and their displaed titles.
     */
    public $columnNames = [
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate", 
        "GLAccountNumber" => "Account Number",
        "GLAccountName" => "Account Name",
        "GLAccountDescription" => "Account Description",
        "GLAccountUse" => "Account Use",
        "GLAccountType" => "Account Type",
        "GLAccountCode" => "Account Group",
        "GLBalanceType" => "Balance Type",
        "GLAccountBalance" => "Account Balance",
        "GLOtherNotes" => "Other Notes",
        "GLCurrentYearPeriod1" => "GL Current Year Period 1",	 
        "GLCurrentYearPeriod2" => "GL Current Year Period 2",
        "GLCurrentYearPeriod3" => "GL Current Year Period 3",	 
        "GLCurrentYearPeriod4" => "GL Current Year Period 4",	 
        "GLCurrentYearPeriod5" => "GL Current Year Period 5",	 
        "GLCurrentYearPeriod6" => "GL Current Year Period 6",	 
        "GLCurrentYearPeriod7" => "GL Current Year Period 7",	 
        "GLCurrentYearPeriod8" => "GL Current Year Period 8",	 
        "GLCurrentYearPeriod9" => "GL Current Year Period 9",	 
        "GLCurrentYearPeriod10" => "GL Current Year Period 10",
        "GLCurrentYearPeriod11" => "GL Current Year Period 11",
        "GLCurrentYearPeriod12" => "GL Current Year Period 12",
        "GLCurrentYearPeriod13" => "GL Current Year Period 13",
        "GLCurrentYearPeriod14" => "GL Current Year Period 14",
        "GLBudgetBeginningBalance" => "GL Budget Beginning Balance",
        "GLBudgetPeriod1" => "GL Budget Period 1",
        "GLBudgetPeriod2" => "GL Budget Period 2",
        "GLBudgetPeriod3" => "GL Budget Period 3",
        "GLBudgetPeriod4" => "GL Budget Period 4",
        "GLBudgetPeriod5" => "GL Budget Period 5",
        "GLBudgetPeriod6" => "GL Budget Period 6",
        "GLBudgetPeriod7" => "GL Budget Period 7",
        "GLBudgetPeriod8" => "GL Budget Period 8",
        "GLBudgetPeriod9" => "GL Budget Period 9",
        "GLBudgetPeriod10" => "GL Budget Period 10",
        "GLBudgetPeriod11" => "GL Budget Period 11",
        "GLBudgetPeriod12" => "GL Budget Period 12",
        "GLBudgetPeriod13" => "GL Budget Period 13",
        "GLBudgetPeriod14" => "GL Budget Period 14",
        "GLPriorYearBeginningBalance" => "GL Prior Year Beginning Balance",
        "GLPriorYearPeriod1" => "GL Prior Year Period 1",
        "GLPriorYearPeriod2" => "GL Prior Year Period 2",
        "GLPriorYearPeriod3" => "GL Prior Year Period 3",
        "GLPriorYearPeriod4" => "GL Prior Year Period 4",	 
        "GLPriortYearPeriod5" => "GL Prior Year Period 5", //ERROR in sql, musql be Prior	 
        "GLPriorYearPeriod6" => "GL Prior Year Period 6",	 
        "GLPriorYearPeriod7" => "GL Prior Year Period 7",	 
        "GLPriorYearPeriod8" => "GL Prior Year Period 8",	 
        "GLPriorYearPeriod9" => "GL Prior Year Period 9",	 
        "GLPriortYearPeriod10" => "GL Prior Year Period 10",//ERROR in sql, musql be Prior	 
        "GLPriorYearPeriod11" => "GL Prior Year Period 11",
        "GLPriorYearPeriod12" => "GL Prior Year Period 12",
        "GLPriorYearPeriod13" => "GL Prior Year Period 13",
        "GLPriorYearPeriod14" => "GL Prior Year Period 14"
    ];

    //getting list of available GLAccount Groups
    public function getGLAccountGroups(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT GLAccountGroupID from ledgeraccountgroup WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' ORDER BY GLAccountGroupID ASC", array());
        foreach($result as $value)
            $res[$value->GLAccountGroupID] = [
                "title" => $value->GLAccountGroupID,
                "value" => $value->GLAccountGroupID                
            ];
        
        return $res;
    }
    
    //getting list of available GLAccount
    public function getGLAccountTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT GLAccountType from ledgeraccounttypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $value)
            $res[$value->GLAccountType] = [
                "title" => $value->GLAccountType,
                "value" => $value->GLAccountType                
            ];
        
        return $res;
    }
    
    //getting list of available values for GLBalanceType 
    public function getGLBalanceTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT GLBalanceType from ledgerbalancetype WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $value)
            $res[$value->GLBalanceType] = [
                "title" => $value->GLBalanceType,
                "value" => $value->GLBalanceType                
            ];
        
        return $res;
    }
}
?>