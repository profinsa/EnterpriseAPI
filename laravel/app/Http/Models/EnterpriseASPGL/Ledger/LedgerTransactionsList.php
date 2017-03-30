<?php
namespace App\Models;
require __DIR__ . "/../../../Models/gridDataSource.php";

use Illuminate\Support\Facades\DB;
use Session;

class gridData extends gridDataSource{
    protected $tableName = "ledgertransactions";
    public $dashboardTitle ="Ledger Transactions";
    public $breadCrumbTitle ="Ledger Transactions";
    public $idField ="GLTransactionNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","GLTransactionNumber"];
    public $modes = ["grid", "view", "edit", "new", "delete"];
    protected $gridConditions = "GLTransactionPostedYN='0'";
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
                "defaultValue" => ""
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
                "inputType" => "text",
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
                "defaultValue" => "0"
            ],
            "GLTransactionRecurringYN" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            /*            "Reversal" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Approved" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApprovedBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ApprovedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "EnteredBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BatchControlNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BatchControlTotal" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Signature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SignaturePassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupervisorSignature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupervisorPassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ManagerSignature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ManagerPassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],*/
            "Memorize" => [
                "dbType" => "tinyint(1)",
                "inputType" => "text",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ]];
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
        $user = Session::get("user");

        echo "CALL LedgerTransactions_PostManual('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["GLTransactionNumber"] . "',@PostingResult,@DisbalanceAmount,@IsValid,@SWP_RET_VALUE)";
        DB::statement("CALL LedgerTransactions_PostManual('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["GLTransactionNumber"] . "',@PostingResult,@DisbalanceAmount,@IsValid,@SWP_RET_VALUE)");

        $results = DB::select('select @PostingResult as PostingResult, @DisbalanceAmount as DisbalanceAmount, @IsValid as IsValid, @SWP_RET_VALUE as SWP_RET_VALUE');
        if($results[0]->SWP_RET_VALUE > -1){
            header('Content-Type: application/json');
            echo json_encode($results);
        }else
            return response(json_encode($results), 400)->header('Content-Type', 'text/plain');
        
    }
}
?>
