<?php
require "./models/gridDataSource.php";

class LedgerAccountTransactionsList extends gridDataSource{
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
                "defaultValue" => "USD"
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

    public function PostManual(){
        $user = $_SESSION["user"];

        $GLOBALS["capsule"]::statement("CALL LedgerTransactions_PostManual('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["GLTransactionNumber"] . "',@PostingResult,@DisbalanceAmount,@IsValid,@SWP_RET_VALUE)");

        $results = $GLOBALS["capsule"]::select('select @PostingResult as PostingResult, @DisbalanceAmount as DisbalanceAmount, @IsValid as IsValid, @SWP_RET_VALUE as SWP_RET_VALUE');
        if($results[0]->SWP_RET_VALUE > -1)
            echo $results[0]->PostingResult;
        else {
            http_response_code(400);
            echo $results[0]->PostingResult;
        }
    }

    public function Memorize(){
        $user = $_SESSION["user"];
        $keyValues = explode("__", $_POST["id"]);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        $GLOBALS["capsule"]::update("UPDATE " . $this->tableName . " set Memorize='" . ($_POST["Memorize"] == '1' ? '0' : '1') . "' WHERE ". $keyFields);
        echo "ok";
    }

    public function getPage($GLTransactionAccount){
        $user = $_SESSION["user"];
        $result = [];

        $keyValues = explode("__", $_GET["item"]);

        $details = $GLOBALS["capsule"]::select("SELECT GLTransactionNumber from ledgertransactionsdetail WHERE CompanyID='". $user["CompanyID"] . "' AND DivisionID='"  . $user["DivisionID"] . "' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLTransactionAccount='" . $keyValues[3] . "'", array());
        $fieldValues = [];
        
        foreach($details as $detail) {
            $fieldValues[] = $detail->GLTransactionNumber;
        }

        if (count($fieldValues) > 0) {
            $result = $GLOBALS["capsule"]::select("SELECT * from ledgertransactions WHERE CompanyID='". $user["CompanyID"] . "' AND DivisionID='"  . $user["DivisionID"] . "' AND DepartmentID='" . $user["DepartmentID"] . "' AND GLTransactionNumber IN (" . implode(",", $fieldValues) . ")", array());
        }

        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
}
?>
