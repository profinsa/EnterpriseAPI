<?php
/*
  Name of Page: chartOfAccounts model

  Method: Model for GeneralLedger/chartOfAccounts. It provides data from database and default values, column names and categories

  Date created: Nikita Zaharov, 13.02.2017

  Use: this model used by gridView for:
  - as dictionary for view during building interface(tabs and them names, fields and them names etc, column name and translationid corresponding)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods has own parameters

  Output parameters:
  - dictionaries as public properties
  - methods has own output

  Called from:
  created and used for ajax requests by Grid controller
  used as model by gridView

  Calls:
  sql

  Last Modified: 05.06.2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class LedgerChartOfAccountsList extends gridDataSource{
    public $tableName = "ledgerchartofaccounts"; //table name which used for read and write fields
    //fields to render in grid
    public $dashboardTitle = "Chart Of Accounts"; //title in dashboard
    public $breadCrumbTitle = "Chart Of Accounts"; //title in breadCrumb
    public $idField = "GLAccountNumber"; //fieldname in database on which is selecting(CompanyID, DevisionID, DepartmentID, GLAccountNumber)
    public $idFields = ["CompanyID", "DivisionID", "DepartmentID", "GLAccountNumber"];

    public $gridFields = [ //field list for showing in grid mode(columns)
        "GLAccountNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLAccountCode" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLSubAccountCode" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""

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
            "GLAccountCode" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "DEFAULT",
                "defaultOverride" => true,
                "disabledEdit" => true,
                "dataProvider" => "getGLAccountGroups"
            ],
            "GLSubAccountCode" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "DEFAULT",
                "defaultOverride" => true,
                "disabledEdit" => true,
                "dataProvider" => "getGLAccountSubGroups",
                "depends" => [
                    "GLAccountCode" => "GLAccountCode"
                ],
            ],
            "GLAccountNumber" => [
                "dbType" => "varchar(128)",
                "disabledEdit" => true,
                "inputType" => "text",
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
        ],
        "Transactions" => [
            "GLAccountNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text"
            ],
        ]
    ];

    public $detailPages = [
        "Transactions" => [
            "hideFields" => "true",
            "disableNew" => "true",
            "deleteDisabled" => "true",
            //"editDisabled" => "true",
            "viewPath" => "GeneralLedger/Ledger/ViewGLTransactions",
            "newKeyField" => "GLAccountNumber",
            "keyFields" => ["GLAccountNumber"],
            "detailIdFields" => ["CompanyID","DivisionID","DepartmentID","GLTransactionNumber"],
            "gridFields" => [
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
            ]
        ]
    ];
        
    public function getTransactions($ID){
        $user = Session::get("user");
        $result = DB::select("SELECT * from ledgertransactions LEFT JOIN ledgertransactionsdetail ON ledgertransactions.GLTransactionNumber=ledgertransactionsdetail.GLTransactionNumber AND ledgertransactions.CompanyID=ledgertransactionsdetail.CompanyID  AND ledgertransactions.DivisionID=ledgertransactionsdetail.DivisionID  AND ledgertransactions.DepartmentID=ledgertransactionsdetail.DepartmentID WHERE ledgertransactionsdetail.CompanyID=? AND ledgertransactionsdetail.DivisionID=? AND ledgertransactionsdetail.DepartmentID=? AND ledgertransactionsdetail.GLTransactionAccount=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $ID]);


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    /* table column to translation/ObjID
       many columns not translated by them names. For that column must be converted to displayed title. This is table contains column names and their displaed titles.
     */
    public $columnNames = [
        "GLAccountNumber" => "Account Number",
        "GLAccountName" => "Account Name",
        "GLAccountDescription" => "Account Description",
        "GLAccountUse" => "Account Use",
        "GLAccountType" => "Account Type",
        "GLSubAccountCode" => "Account Sub Group",
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
        "GLPriortYearPeriod5" => "GL Prior Year Period 5", //ERROR in sql, must be Prior	 
        "GLPriorYearPeriod6" => "GL Prior Year Period 6",	 
        "GLPriorYearPeriod7" => "GL Prior Year Period 7",	 
        "GLPriorYearPeriod8" => "GL Prior Year Period 8",	 
        "GLPriorYearPeriod9" => "GL Prior Year Period 9",	 
        "GLPriortYearPeriod10" => "GL Prior Year Period 10",//ERROR in sql, must be Prior	 
        "GLPriorYearPeriod11" => "GL Prior Year Period 11",
        "GLPriorYearPeriod12" => "GL Prior Year Period 12",
        "GLPriorYearPeriod13" => "GL Prior Year Period 13",
        "GLPriorYearPeriod14" => "GL Prior Year Period 14",
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
        "ApprovedBy" => "Approved By",
        "ApprovedDate" => "Approved Date",
    ];

    //getting list of available GLAccount Groups
    public function getGLAccountGroups(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT GLAccountGroupID from ledgeraccountgroup WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' ORDER BY GLAccountGroupID ASC", array());
        foreach($result as $value)
            $res[$value->GLAccountGroupID] = [
                "title" => $value->GLAccountGroupID,
                "value" => $value->GLAccountGroupID                
            ];
        
        return $res;
    }
    
    //getting list of available GLAccount Groups
    public function getGLAccountSubGroups(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT GLAccountCode, GLSubAccountCode from ledgersubaccountgroup WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' ORDER BY GLSubAccountCode ASC", array());
        foreach($result as $value)
            $res[$value->GLSubAccountCode] = [
                "GLAccountCode" => $value->GLAccountCode,
                "title" => $value->GLSubAccountCode,
                "value" => $value->GLSubAccountCode                
            ];
        
        return $res;
    }
    
    //getting list of available GLAccount
    public function getGLAccountTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT GLAccountType from ledgeraccounttypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $value)
            $res[$value->GLAccountType] = [
                "title" => $value->GLAccountType,
                "value" => $value->GLAccountType                
            ];
        
        return $res;
    }
    
    //getting list of available values for GLBalanceType 
    public function getGLBalanceTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT GLBalanceType from ledgerbalancetype WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $value)
            $res[$value->GLBalanceType] = [
                "title" => $value->GLBalanceType,
                "value" => $value->GLBalanceType                
            ];
        
        return $res;
    }

    //add row to table
    public function insertItem($values, $remoteCall = false){
        $user = Session::get("user");
        
        $insert_fields = "";
        $insert_values = "";
        $alreadyUsed = [];
        foreach($this->editCategories as $category=>$arr){
            foreach($this->editCategories[$category] as $name=>$value){
                if(key_exists($name, $values) && !key_exists($name, $alreadyUsed) && $values[$name] != "" && !key_exists("autogenerated", $value)){
                    if(key_exists("dirtyAutoincrement", $value))
                        $values[$name] = $this->dirtyAutoincrementColumn($this->tableName, $name);
                    $alreadyUsed[$name] = true;
                    if($value["inputType"] == 'timestamp' || $value["inputType"] == 'datetime')
                        $values[$name] = date("Y-m-d H:i:s", strtotime($values[$name]));
                    else if(key_exists("formatFunction", $value)){
                        $formatFunction = $value["formatFunction"];
                        $values[$name] = $this->$formatFunction($values, "editCategories", $name, $values[$name], true);
                    }
                    if(key_exists("format", $value) && preg_match('/decimal/', $value["dbType"]))
                        $values[$name] = str_replace(",", "", $values[$name]);

                    if($name == "GLAccountNumber")
                        $values[$name] = "{$values["GLAccountCode"]}/{$values["GLSubAccountCode"]}/{$values[$name]}";
                    
                    if($insert_fields == ""){
                        $insert_fields = $name;
                        $insert_values = "'" . $values[$name] . "'";
                    }else{
                        $insert_fields .= "," . $name;
                        $insert_values .= ",'" . $values[$name] . "'";
                    }
                }
            }
        }

        $insert_fields .= ',CompanyID,DivisionID,DepartmentID';
        $insert_values .= ",'" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "'";
        DB::insert("INSERT INTO " . $this->tableName . "(" . $insert_fields . ") values(" . $insert_values .")", array());
    }
    
    public function SaveToStored(){
        $user = Session::get("user");
        $result = DB::Select("select GLAccountNumber from LedgerStoredChartOfAccounts WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND GLAccountNumber=? AND Industry=? AND ChartType=?", array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $_POST["GLAccountNumber"], $_POST["Industry"], $_POST["ChartType"]));
        if(count($result))
            return response("This accounts is already added to Stored Accounts", 400)->header('Content-Type', 'text/plain');

        $result = DB::Select("select * from LedgerChartOfAccounts WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND GLAccountNumber=?", array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $_POST["GLAccountNumber"]))[0];

        $values = [];
        $values[] = "'" . $_POST["Industry"] . "'";
        $values[] = "'" . $_POST["ChartType"] . "'";
        $values[] = "'" . $_POST["ChartDescription"] . "'";
        foreach($result as $key=>$value){
            if($value != "")
                $values[] = "'" . $value . "'";
            else
                $values[] = "NULL";
        }

        DB::Insert("INSERT INTO LedgerStoredChartOfAccounts VALUES(" . implode(",", $values) . ")", array());
        
        echo "ok";
    }
}
?>