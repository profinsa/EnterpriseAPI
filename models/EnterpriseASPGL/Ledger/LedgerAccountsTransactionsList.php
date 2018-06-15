<?php
require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    public $tableName = "ledgertransactions";
    public $gridConditions = "1=1";
    public $dashboardTitle ="Ledger Transactions";
    public $breadCrumbTitle ="Ledger Transactions";
    public $idField ="GLTransactionNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","GLTransactionNumber"];
    public $modes = ["grid"];
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
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => "(new)",
                "dirtyAutoincrement" => "true"
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
        "ProjectID" => "Project ID"
    ];

    public $detailPages = [
        "Main" => [
            //            "hideFields" => "true",
            //"disableNew" => "true",
            //"deleteDisabled" => "true",
            //"editDisabled" => "true",
            "viewPath" => "GeneralLedger/Ledger/LedgerTransactionsDetail",
            "newKeyField" => "GLTransactionNumber",
            "keyFields" => ["GLTransactionNumber", "GLTransactionNumberDetail"],
            "detailIdFields" => ["CompanyID","DivisionID","DepartmentID","GLTransactionNumber"],
            "gridFields" => [
                "GLTransactionAccount" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "dropdown",
                    "dataProvider" => "getAccounts",
                    "defaultValue" => ""
                ],
                "GLDebitAmount" => [
                    "dbType" => "decimal(19,4)",
                    "inputType" => "text",
                    "defaultValue" => "",
                    "format" => "{0:n}",
                    //"formatFunction" => "currencyFormat"
                ],
                "GLCreditAmount" => [
                    "dbType" => "decimal(19,4)",
                    "inputType" => "text",
                    "defaultValue" => "",
                    "format" => "{0:n}",
                    //                    "formatFunction" => "currencyFormat"
                ],
                "ProjectID" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "dropdown",
                    "dataProvider" => "getProjects",
                    "defaultValue" => ""
                ]
            ]
        ]
    ];

    public function getMain($GLTransactionNumber){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->detailPages["Main"]["gridFields"] as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailPages["Main"]["detailIdFields"] as $key){
            switch($key){
            case "CompanyID" :
                $keyFields .= "CompanyID='" . $user["CompanyID"] . "' AND ";
                break;
            case "DivisionID" :
                $keyFields .= "DivisionID='" . $user["DivisionID"] . "' AND ";
                break;
            case "DepartmentID" :
                $keyFields .= "DepartmentID='" . $user["DepartmentID"] . "' AND ";
                break;
            }
            if(!in_array($key, $fields))
                $fields[] = $key;                
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $keyFields .= " AND GLTransactionNumber='" . $GLTransactionNumber . "'";
        
        $result = DB::select("SELECT * from ledgertransactionsdetail WHERE ". $keyFields, array());

        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
    
    public function deleteMain(){
        $user = Session::get("user");
        $idFields = ["CompanyID","DivisionID","DepartmentID","GLTransactionNumber", "GLTransactionNumberDetail"];
        $keyValues = explode("__", $_GET["item"]);
        $keyFields = "";
        $fcount = 0;
        foreach($idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        DB::delete("DELETE from ledgertransactionsdetail " .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }

    public function PostManual(){
        $user = Session::get("user");

        DB::statement("CALL LedgerTransactions_PostManual('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["GLTransactionNumber"] . "',@PostingResult,@DisbalanceAmount,@IsValid,@SWP_RET_VALUE)");

        $results = DB::select('select @PostingResult as PostingResult, @DisbalanceAmount as DisbalanceAmount, @IsValid as IsValid, @SWP_RET_VALUE as SWP_RET_VALUE');
        if($results[0]->SWP_RET_VALUE > -1){
            header('Content-Type: application/json');
            echo $results[0]->PostingResult;
        }else
            return response($results[0]->PostingResult, 400)->header('Content-Type', 'text/plain');
        
    }

    public function Memorize(){
        $user = Session::get("user");
        $keyValues = explode("__", $_POST["id"]);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        DB::update("UPDATE " . $this->tableName . " set Memorize='" . ($_POST["Memorize"] == '1' ? '0' : '1') . "' WHERE ". $keyFields);
        echo "ok";
    }

    //getting rows for grid
    public function getPage($CashFlowID){
        $user = Session::get("user");
        $result = [];

        $keyValues = explode("__", $CashFlowID);

        switch($keyValues[3]) {
            case "CollectionsFromCustomersIncome":
            $details = DB::select("SELECT GLTransactionNumber
                FROM
                LedgerTransactionsDetail
                INNER JOIN LedgerChartOfAccounts ON
                GLTransactionAccount = GLAccountNumber AND
                LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
                LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
                LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
                WHERE
                LedgerTransactionsDetail.DivisionID = '"  . $user["DivisionID"] . "' AND
                LedgerTransactionsDetail.DepartmentID = '" . $user["DepartmentID"] . "' AND
                GLAccountNumber LIKE '4%'
                
                UNION
                SELECT GLTransactionNumber
                FROM
                LedgerTransactionsDetail
                INNER JOIN LedgerChartOfAccounts ON
                GLTransactionAccount = GLAccountNumber AND
                LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
                LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
                LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
                WHERE
                LedgerTransactionsDetail.CompanyID = '". $user["CompanyID"] . "' AND
                LedgerTransactionsDetail.DivisionID = '"  . $user["DivisionID"] . "' AND
                LedgerTransactionsDetail.DepartmentID = '" . $user["DepartmentID"] . "' AND
                GLAccountNumber LIKE '12%'", array());
            break;
            case "PaymentsForMerchandiseCostofGoods":
            $details = DB::select("SELECT GLTransactionNumber
                FROM
                LedgerTransactionsDetail
                INNER JOIN LedgerChartOfAccounts ON
                GLTransactionAccount = GLAccountNumber AND
                LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
                LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
                LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
                WHERE
                LedgerTransactionsDetail.DivisionID = '"  . $user["DivisionID"] . "' AND
                LedgerTransactionsDetail.DepartmentID = '" . $user["DepartmentID"] . "' AND
                GLAccountNumber LIKE '5%'", array());
            break;
            case "PaymentsForExpenses":
            $details = DB::select("SELECT GLTransactionNumber
                FROM
                LedgerTransactionsDetail
                INNER JOIN LedgerChartOfAccounts ON
                GLTransactionAccount = GLAccountNumber AND
                LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
                LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
                LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
                WHERE
                LedgerTransactionsDetail.DivisionID = '"  . $user["DivisionID"] . "' AND
                LedgerTransactionsDetail.DepartmentID = '" . $user["DepartmentID"] . "' AND
                GLAccountNumber >= '6' AND
                GLAccountNumber < '9'", array());
            break;
            case "PurchaseOfEquipment":
            $details = DB::select("SELECT GLTransactionNumber
                FROM
                LedgerTransactionsDetail
                INNER JOIN LedgerChartOfAccounts ON
                GLTransactionAccount = GLAccountNumber AND
                LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
                LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
                LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
                WHERE
                LedgerTransactionsDetail.DivisionID = '"  . $user["DivisionID"] . "' AND
                LedgerTransactionsDetail.DepartmentID = '" . $user["DepartmentID"] . "' AND
                GLAccountNumber LIKE '15%'", array());
            break;
            case "Other":
            $details = DB::select("SELECT GLTransactionNumber
                FROM
                LedgerTransactionsDetail
                INNER JOIN LedgerChartOfAccounts ON
                GLTransactionAccount = GLAccountNumber AND
                LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
                LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
                LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
                WHERE
                LedgerTransactionsDetail.DivisionID = '"  . $user["DivisionID"] . "' AND
                LedgerTransactionsDetail.DepartmentID = '" . $user["DepartmentID"] . "' AND
                GLAccountNumber LIKE '16%'", array());
            break;
            case "FinancingActivitiesCredit":
            $details = DB::select("SELECT GLTransactionNumber
                FROM
                LedgerTransactionsDetail
                INNER JOIN LedgerChartOfAccounts ON
                GLTransactionAccount = GLAccountNumber AND
                LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
                LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
                LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
                WHERE
                LedgerTransactionsDetail.DivisionID = '"  . $user["DivisionID"] . "' AND
                LedgerTransactionsDetail.DepartmentID = '" . $user["DepartmentID"] . "' AND
                GLCreditAmount <> 0 AND
                GLAccountType = 'Equity'
                AND GLAccountNumber Like '3%'", array());
            break;
            case "FinancingActivitiesDebit":
            $details = DB::select("SELECT GLTransactionNumber
                FROM
                LedgerTransactionsDetail
                INNER JOIN LedgerChartOfAccounts ON
                GLTransactionAccount = GLAccountNumber AND
                LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
                LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
                LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
                WHERE
                LedgerTransactionsDetail.DivisionID = '"  . $user["DivisionID"] . "' AND
                LedgerTransactionsDetail.DepartmentID = '" . $user["DepartmentID"] . "' AND
                GLDebitAmount <> 0 AND
                GLAccountType = 'Equity'
                AND GLAccountNumber Like '3%'", array());
            break;
        }

        $fieldValues = [];
        
        foreach($details as $detail) {
            $fieldValues[] = $detail->GLTransactionNumber;
        }

        if (count($fieldValues) > 0) {
            $result = DB::select("SELECT * from ledgertransactions WHERE CompanyID='". $user["CompanyID"] . "' AND DivisionID='"  . $user["DivisionID"] . "' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLTransactionNumber IN (" . implode(",", $fieldValues) . ") ORDER BY GLTransactionDate", array());
        }

        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
}
?>
