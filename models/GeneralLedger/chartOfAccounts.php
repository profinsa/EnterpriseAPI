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

Last Modified: 06.03.2016
Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "ledgerchartofaccounts"; //table name which used for read and write fields
    //fields to render in grid
    protected $gridFields = [ //field list for showing in grid mode(columns)
            "GLAccountNumber",
            "GLAccountCode",
            "GLAccountName",
            "GLAccountType",
            "GLBalanceType",
            "GLAccountBalance",
    ];

    public $dashboardTitle = "Chart Of Accounts"; //title in dashboard
    public $breadCrumbTitle = "Chart Of Accounts"; //title in breadCrumb
    public $idField = "GLAccountNumber"; //fieldname in database on which is selecting(CompanyID, DevisionID, DepartmentID, GLAccountNumber)

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
                "disableEdit" => true,
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountCode" => [
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getGLAccountGroups"
            ],
            "GLAccountName" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountDescription" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountUse" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountType" => [
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getGLAccountTypes"
            ],
            "GLBalanceType" => [
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getGLBalanceTypes"
            ],
            "GLAccountBalance" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLOtherNotes" => [
                "inputType" => "text",
                "defaultValue" => ""
            ]	
        ],
        "Current" => [
            "GLCurrentYearPeriod1" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],	 
            "GLCurrentYearPeriod2" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLCurrentYearPeriod3" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLCurrentYearPeriod4" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLCurrentYearPeriod5" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLCurrentYearPeriod6" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLCurrentYearPeriod7" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLCurrentYearPeriod8" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLCurrentYearPeriod9" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLCurrentYearPeriod10" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLCurrentYearPeriod11" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLCurrentYearPeriod12" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLCurrentYearPeriod13" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLCurrentYearPeriod14" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ]
        ],
        "Budget" => [
            "GLBudgetBeginningBalance" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod1" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod2" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod3" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod4" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod5" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod6" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod7" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod8" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod9" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod10" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod11" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod12" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod13" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLBudgetPeriod14" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ]
        ],
        "History" => [
            "GLPriorYearBeginningBalance" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLPriorYearPeriod1" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLPriorYearPeriod2" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLPriorYearPeriod3" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLPriorYearPeriod4" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLPriortYearPeriod5" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],//ERROR in sql, must be Prior
            "GLPriorYearPeriod6" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLPriorYearPeriod7" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLPriorYearPeriod8" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLPriorYearPeriod9" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLPriortYearPeriod10" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],//ERROR in sql, must be Prior	 
            "GLPriorYearPeriod11" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLPriorYearPeriod12" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLPriorYearPeriod13" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLPriorYearPeriod14" => [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ]
        ]
    ];

    /* table column to translation/ObjID
       many columns not translated by them names. For that column must be converted to displayed title. This is table contains column names and their displaed titles.
     */
    public $columnNames = [
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