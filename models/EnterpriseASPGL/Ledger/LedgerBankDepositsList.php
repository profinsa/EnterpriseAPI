<?php
/*
Name of Page: Bank Deposits model

Method: Model for gridView. It provides data from database and default values, column names and categories

Date created: Nikita Zaharov, 09.20.2017

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

Last Modified: 09.21.2017
Last Modified by: Nikita Zaharov
*/

require __DIR__ . "/../../../models/gridDataSource.php";

class LedgerBankDepositsList extends gridDataSource{
    public $tableName = "ledgertransactions";
    public $gridConditions = "UPPER(GLTransactionNumber) != 'DEFAULT' AND GLTransactionTypeID='Deposit'";
    public $dashboardTitle ="Bank Deposits";
    public $breadCrumbTitle ="Bank Deposits";
    public $idField ="GLTransactionNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","GLTransactionNumber"];
    public $modes = ["grid", "view", "new", "delete"];
    //    public $features = ["selecting"];
    public $gridFields = [
        "GLTransactionNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLTransactionTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "required" => true
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
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => "(new)",
                "dirtyAutoincrement" => "true"
            ],
            "GLTransactionTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getLedgerTransactionTypes",
                "required" => true,
                "disabledNew" => "true",
                "disabledEdit" => "true",
                "defaultOverride" => true,
                "defaultValue" => "Deposit"
            ],
            "GLTransactionDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            /*            "SystemDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
                ],*/
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
                "inputType" => "dropdown",
                "dataProvider" => "getCurrencyTypes",
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
            /*            "GLTransactionBalance" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
                ],*/
            "GLTransactionPostedYN" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "disabledEdit" => "true",
                "disabledNew" => "true",
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
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => "0"
            ],
            "GLTransactionRecurringYN" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => "0"
            ],
            "Memorize" => [
                "dbType" => "tinyint(1)",
                "inputType" => "text",
                "inputType" => "checkbox",
                "disabledEdit" => "true",
                "disabledNew" => "true",
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
        "ApprovedBy" => "Approved By",
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
        "Memorize" => "Memorize",
        "GLTransactionAccount" => "Account",
        "GLTransactionNumberDetail" => "Detail Number",
        "GLDebitAmount" => "Debit Amount",
        "GLCreditAmount" => "Credit Amount",
        "ProjectID" => "Project ID",
        "GLControlNumber" => "GL Control Number"
    ];

    public $detailPagesAsSubgrid = true;
    public $detailSubgridModes = [
        "view" => ["view", "grid"]
    ];
    public $detailPages = [
        "Main" => []
    ];

    public function Save(){
        $user = Session::get("user");

        DB::statement("CALL LedgerTransactions_PostManual('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["GLTransactionNumber"] . "',@PostingResult,@DisbalanceAmount,@IsValid,@SWP_RET_VALUE)");

        $results = DB::select('select @PostingResult as PostingResult, @DisbalanceAmount as DisbalanceAmount, @IsValid as IsValid, @SWP_RET_VALUE as SWP_RET_VALUE');
        if($results[0]->SWP_RET_VALUE > -1){
            echo $results[0]->PostingResult;
        }else{
            http_response_code(400);
            echo $results[0]->PostingResult;
        }
    }

    public function Recalc(){
        $user = Session::get("user");
        $details = DB::select("SELECT * from ledgertransactionsdetail WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND GLTransactionNumber=?", array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $_POST["GLTransactionNumber"]));
        $amount = 0;
        foreach($details as $dkey=>$detail)
            $amount += $detail->GLDebitAmount;
        
        DB::update("UPDATE ledgertransactions set GLTransactionAmount=? WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND GLTransactionNumber=?", array($amount, $user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $_POST["GLTransactionNumber"]));
    }
    
    public function Clear(){
        $user = Session::get("user");

        $numbers = explode(",", $_POST["GLTransactionNumbers"]);
        $success = true;
        foreach($numbers as $number){
            DB::statement("CALL LedgerTransactions_CopyToHistory2('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $number . "',@SWP_RET_VALUE)");

            $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
            if($result[0]->SWP_RET_VALUE == -1)
                $success = false;
        }

        if($success)
            header('Content-Type: application/json');
        else
            return response("failed", 400)->header('Content-Type', 'text/plain');
    }
}
?>
