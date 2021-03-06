<?php
require "./models/gridDataSource.php";

class LedgerTransactionsClosedDetail extends gridDataSource{
    public $tableName = "ledgertransactionsdetail";
    public $dashboardTitle ="Ledger Transactions Detail";
    public $breadCrumbTitle ="Ledger Transactions Detail";
    public $idField ="GLTransactionNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","GLTransactionNumber","GLTransactionNumberDetail"];
    public $modes = ["grid", "view", "edit", "new"];
    public $gridFields = [
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
            "inputType" => "dropdown",
            "dataProvider" => "getProjects",
            "defaultValue" => ""
        ]
    ];

    public $editCategories = [
        "Main" => [
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
        ]
    ];
    public $columnNames = [
        "GLTransactionNumber" => "Transaction Number",
        "GLTransactionNumberDelail" => "Transaction Number Detail",
        "GLTransactionAccount" => "Account",
        "GLTransactionTypeID" => "Type",
        "CurrencyID" => "Currency",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "GLDebitAmount" => "Debit Amount",
        "GLCreditAmount" => "Credit Amount",
        "ProjectID" => "Project ID"
    ];

    public function PostManual(){
        $user = $_SESSION["user"];

        $GLOBALS["capsule"]::statement("CALL LedgerTransactions_PostManual('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["GLTransactionNumber"] . "',@PostingResult,@DisbalanceAmount,@IsValid,@SWP_RET_VALUE)");

        $results = $GLOBALS["capsule"]::select('select @PostingResult as PostingResult, @DisbalanceAmount as DisbalanceAmount, @IsValid as IsValid, @SWP_RET_VALUE as SWP_RET_VALUE');
        if($results[0]->SWP_RET_VALUE > -1){
            header('Content-Type: application/json');
            echo json_encode($results);
        }else
            return response(json_encode($results), 400)->header('Content-Type', 'text/plain');
        
    }

        //getting rows for grid
    public function getPage($id){
        $user = $_SESSION["user"];

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
            if(count($keyValues))
                $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = $GLOBALS["capsule"]::select("SELECT " . implode(",", $columns) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true);
        
        return $result;        
    }

        //add row to table
    public function insertSubgridItem($values, $items){
        $user = $_SESSION["user"];
        
        $insert_fields = "";
        $insert_values = "";
        foreach($this->editCategories as $category=>$arr){
            foreach($this->editCategories[$category] as $name=>$value){
                if(key_exists($name, $values)){
                    if($value["inputType"] == 'timestamp' || $value["inputType"] == 'datetime')
                        $values[$name] = date("Y-m-d H:i:s", strtotime($values[$name]));
                    else if(key_exists("formatFunction", $value)){
                        $formatFunction = $value["formatFunction"];
                        $values[$name] = $this->$formatFunction($values, "editCategories", $name, $values[$name], true);
                    }
                    if(key_exists("format", $value) && preg_match('/decimal/', $value["dbType"]))
                        $values[$name] = str_replace(",", "", $values[$name]);

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

        $keyValues = explode("__", $items);
        
        $insert_fields .= ',CompanyID,DivisionID,DepartmentID,GLTransactionNumber';
        $insert_values .= ",'" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $keyValues[3] . "'";
        $GLOBALS["capsule"]::insert("INSERT INTO " . $this->tableName . "(" . $insert_fields . ") values(" . $insert_values .")");
    }
}
?>
