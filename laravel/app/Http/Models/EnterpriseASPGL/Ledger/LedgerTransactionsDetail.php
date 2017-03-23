<?php
namespace App\Models;
require __DIR__ . "/../../../Models/gridDataSource.php";

use Illuminate\Support\Facades\DB;
use Session;

class gridData extends gridDataSource{
    protected $tableName = "ledgertransactionsdetail";
    public $dashboardTitle ="Ledger Transactions Detail";
    public $breadCrumbTitle ="Ledger Transactions Detail";
    public $idField ="GLTransactionNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","GLTransactionNumber"];
    public $modes = ["grid", "view", "edit", "new"];
    public $gridFields = [
        "GLTransactionAccount" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "GLDebitAmount" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "defaultValue" => "",
            "addFields" => "CurrencyID",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ],
        "GLCreditAmount" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "defaultValue" => "",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ],
        "ProjectID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
            "GLTransactionNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLTransactionNumberDetail" => [
                "dbType" => "bigint(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLTransactionAccount" => [
                "dbType" => "varchar(36)",
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
            "GLDebitAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
            ],
            "GLCreditAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => "",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat"
            ],
            "ProjectID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "GLTransactionNumber" => "Transaction Number",
        "GLTransactionNumberDelail" => "Transaction Number Detail",
        "GLTransactionAccount" => "GLTransactionAccount",
        "GLTransactionTypeID" => "Type",
        "CurrencyID" => "Currency",
        "CurrencyExchangeRate" => "CurrencyExchangeRate",
        "GLDebitAmount" => "GLDebitAmount",
        "GLCreditAmount" => "GLCreditAmount",
        "ProjectID" => "ProjectID"
    ];

    public function PostManual(){
        $user = Session::get("user");

        DB::statement("CALL LedgerTransactions_PostManual('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["GLTransactionNumber"] . "',@PostingResult,@DisbalanceAmount,@IsValid,@SWP_RET_VALUE)");

        $results = DB::select('select @PostingResult as PostingResult, @DisbalanceAmount as DisbalanceAmount, @IsValid as IsValid, @SWP_RET_VALUE as SWP_RET_VALUE');
        if($results[0]->SWP_RET_VALUE > -1){
            header('Content-Type: application/json');
            echo json_encode($results);
        }else
            return response(json_encode($results), 400)->header('Content-Type', 'text/plain');
        
    }

        //getting rows for grid
    public function getPage($id){
        $user = Session::get("user");
        $columns = [];
        foreach($this->editCategories["Main"] as $key=>$value){
            $columns[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $columns[] = $addfield;
            }
        }
        foreach($this->idFields as $key){
            if(!in_array($key, $columns))
                $columns[] = $key;                
        }
        
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = DB::select("SELECT " . implode(",", $columns) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true);
        
        return $result;        
    }
}
?>
