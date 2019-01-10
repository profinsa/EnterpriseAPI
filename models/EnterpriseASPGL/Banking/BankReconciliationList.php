<?php
/*
  Name of Page: Bank Reconciliation  model

  Method: Model for gridView. It provides data from database and default values, column names and categories

  Date created: Nikita Zaharov, 17.03.2017

  Use: this model used by views/gridView
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
  DB

  Last Modified: 12.26.2018
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

    function numberToStr1($strin){
        return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $strin);
    }
function formatCurrency($value){
    $afterdot = 2;
    if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts))
        return numberToStr1($numberParts[1]) . '.' . substr($numberParts[2], 0, $afterdot);
    else
        return numberToStr1($value) . ".00";

}

class gridData extends gridDataSource{
    public $tableName = "bankreconciliation";
    public $dashboardTitle ="Bank Reconciliation";
    public $breadCrumbTitle ="Bank Reconciliation";
    public $idField ="BankID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","BankID"];
    public $gridFields = [
        "BankID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "BankRecStartDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "BankRecEndDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "GLBankAccount" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "BankRecEndingBalance" => [
            "dbType" => "decimal(19,4)",
            "addFields" => "CurrencyID",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "BankID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "BankRecStartDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "BankRecEndDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
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
            "GLBankAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "BankRecEndingBalance" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "BankRecServiceCharge" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "GLServiceChargeAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "BankRecIntrest" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "GLInterestAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "BankRecOtherCharges" => [
                "dbType" => "decimal(19,4)",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLOtherChargesAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "BankRecAdjustment" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "GLAdjustmentAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "BankRecNotes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Credits" => [
            "BankID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ]
        ],
        "Debits" => [
            "BankID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "BankID" => "Bank ID",
        "BankRecStartDate" => "Start Date",
        "BankRecEndDate" => "End Date",
        "GLBankAccount" => "GL Bank Account",
        "BankRecEndingBalance" => "Balance",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "XRate",
        "BankRecServiceCharge" => "Service Charge",
        "GLServiceChargeAccount" => "GL Service Charge Account",
        "BankRecIntrest" => "Bank Rec Intrest",
        "GLInterestAccount" => "GL Interest Account",
        "BankRecOtherCharges" => "Other Charges",
        "GLOtherChargesAccount" => "GL Other Charges Account",
        "BankRecAdjustment" => "Adjustment",
        "GLAdjustmentAccount" => "GL Adjustment Account",
        "BankRecNotes" => "Notes",
        "Signature" => "Signature",
        "SignaturePassword" => "Signature Password",
        "SupervisorSignature" => "Supervisor Signature",
        "SupervisorPassword" => "Supervisor Password",
        "ManagerSignature" => "Manager Signature",
        "ManagerPassword" => "Manager Password",
        "BankRecDocumentNumber" => "Doc #",
        "BankRecCleared" => "Cleared",
        "BankRecClearedDate" => "Date",
        "BankRecDescription" => "Description",
        "BankRecType" => "Type",
        "BankRecAmount" => "Amount"
    ];

    public $creditsFields = [
        "BankRecDocumentNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "addFields" => "BankID"
        ],
        "BankRecCleared" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ],
        "BankRecClearedDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "BankRecDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "BankRecType" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "CurrencyID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text"
        ],
        "CurrencyExchangeRate" => [
            "dbType" => "float",
            "inputType" => "text"
        ],
        "BankRecAmount" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ]
    ];

    //getting rows for grid
    public function getCreditsPage($id){
        $user = Session::get("user");
        $fields = [];
        foreach($this->creditsFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }

        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        if(property_exists($this, "gridConditions")){
            if($keyFields != "")
                $keyFields .= " AND " . $this->gridConditions;
            else
                $keyFields = $this->gridConditions;
        }
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from BankReconciliationDetailCredits" . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        return json_decode(json_encode($result), true);
    }

    public $debitsFields = [
        "BankRecDocumentNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "addFields" => "BankID"
        ],
        "BankRecCleared" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ],
        "BankRecClearedDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "BankRecDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "BankRecType" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "CurrencyID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text"
        ],
        "CurrencyExchangeRate" => [
            "dbType" => "float",
            "inputType" => "text"
        ],
        "BankRecAmount" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ]
    ];    
    
    //getting rows for grid
    public function getDebitsPage($id){
        $user = Session::get("user");
        $fields = [];
        foreach($this->debitsFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }

        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = DB::select("SELECT " . implode(",", $fields) . " from bankreconciliationdetaildebits" . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        return json_decode(json_encode($result), true);
    }

    public function getEditItem($id, $type){
        $user = Session::get("user");

        $result = parent::getEditItem($id, $type);
        $current_date = date("Y-m-d");
        $result["BankRecStartDate"] = date("Y-m-d", strtotime($current_date." -1 months"));
        $result["BankRecEndDate"] = date("Y-m-d H:i:s");
        $currencyID = DB::select("select CurrencyID from bankaccounts WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND BankID=?", array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $result["BankID"]))[0]->CurrencyID;
        $result["CurrencyID"] = $currencyID;
        $result["CurrencyExchangeRate"] = DB::select("SELECT CurrencyExchangeRate from currencytypes WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND CurrencyID=?", array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $currencyID))[0]->CurrencyExchangeRate;
        return $result;
    }
        
    public function getBalance($item){
        $user = Session::get("user");
        
        $BankRecStartDate = $item["BankRecStartDate"] ? $item["BankRecStartDate"] : date_create()->sub(new DateInterval('P10D'))->format('Y-m-d H:i:s');
        $BankRecEndDate = $item["BankRecEndDate"] ? $item["BankRecEndDate"] : date_create()->format('Y-m-d H:i:s');
        DB::statement("CALL BankReconciliation_Prepare('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','{$item["BankID"]}', 0, '{$item["GLBankAccount"]}', '{$item["GLInterestAccount"]}','{$item["GLServiceChargeAccount"]}','{$item["GLOtherChargesAccount"]}','{$item["GLAdjustmentAccount"]}', '$BankRecStartDate', '$BankRecEndDate', @StartingBalance, @BookBalance, @PeriodBalance, @PeriodCredit, @PeriodDebit, @Result, @CreditBalanceSign, @SWP)", array());

        $result = (array)DB::select('select @StartingBalance, @BookBalance, @PeriodBalance, @PeriodCredit, @PeriodDebit, @Result, @CreditBalanceSign, @SWP', array())[0];

        $keyString = "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$item["BankID"]}";
        $debits = $this->getDebitsPage($keyString);
        $debitsCleared = 0;
        foreach($debits as $row)
            if($row["BankRecCleared"])
                $debitsCleared += $row["BankRecAmount"] * $row["CurrencyExchangeRate"];

        $credits = $this->getCreditsPage($keyString);
        $creditsCleared = 0;
        foreach($credits as $row)
            if($row["BankRecCleared"])
                $creditsCleared += $row["BankRecAmount"] * $row["CurrencyExchangeRate"];

        $debitsOS = $result["@PeriodDebit"] - $debitsCleared;
        $creditsOS = $result["@PeriodCredit"] - $creditsCleared;

        $AdjBookBalance = $result["@StartingBalance"] - $result["@CreditBalanceSign"] * $result["@PeriodBalance"] + $item["BankRecIntrest"] - $item["BankRecServiceCharge"] - $item["BankRecOtherCharges"] - $item["BankRecAdjustment"];
        $BankBalance = $AdjBookBalance - $result["@CreditBalanceSign"] * $debitsOS - $creditsOS;
        $Unreconciled = $BankBalance - $item["BankRecEndingBalance"];
        $EndBookBalance = $AdjBookBalance;
        return [
            "Book" => formatCurrency($result["@BookBalance"]),
            "Bank" => formatCurrency($BankBalance),
            "TotalCredits" => formatCurrency(0),
            "TotalDebits" => formatCurrency(0),
            "AdjBookBalance" => formatCurrency($AdjBookBalance),
            "CreditsOS" => formatCurrency($creditsOS),
            "DebitsOS" => formatCurrency($debitsOS),
            "BankBalance" => formatCurrency(0),
            "StmtBalance" => formatCurrency($item["BankRecEndingBalance"]),
            "Unreconciled" => formatCurrency($Unreconciled),
            "EndBookBalance" => formatCurrency($EndBookBalance),
            "CreditsCleared" => formatCurrency($creditsCleared),
            "DebitsCleared" => formatCurrency($debitsCleared)
        ];
    }

    //updating data of grid item
    public function updateDebitsItem(){
        $user = Session::get("user");
        
        $update_fields = "";
        foreach($_POST as $name=>$value){
            if($update_fields == "")
                $update_fields = $name . "='" . $_POST[$name] . "'";
            else
                $update_fields .= "," . $name . "='" . $_POST[$name] . "'";
        }

        DB::update("UPDATE bankreconciliationdetaildebits set " . $update_fields . " WHERE CompanyID='". $user["CompanyID"] . "' AND DivisionID='" . $user["DivisionID"] . "' AND DepartmentID='" . $user["DepartmentID"] . "' AND BankID='" . $_POST["BankID"] . "' AND BankRecDocumentNumber='" . $_POST["BankRecDocumentNumber"] . "'", array());

        echo "ok";
    }

    //updating data of grid item
    public function updateCreditsItem(){
        $user = Session::get("user");
        
        $update_fields = "";
        foreach($_POST as $name=>$value){
            if($update_fields == "")
                $update_fields = $name . "='" . $_POST[$name] . "'";
            else
                $update_fields .= "," . $name . "='" . $_POST[$name] . "'";
        }

        DB::update("UPDATE bankreconciliationdetailcredits set " . $update_fields . " WHERE CompanyID='". $user["CompanyID"] . "' AND DivisionID='" . $user["DivisionID"] . "' AND DepartmentID='" . $user["DepartmentID"] . "' AND BankID='" . $_POST["BankID"] . "' AND BankRecDocumentNumber='" . $_POST["BankRecDocumentNumber"] . "'", array());

        echo "ok";
    }

    public function Post(){
        $user = Session::get("user");

        $keyValues = explode("__", $_POST["id"]);

        DB::statement("CALL Bank_PostReconciliation('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $keyValues[3] . "', @v_Success ,@SWP_RET_VALUE)", array());

        $result = DB::select('select @v_Success as v_Success, @SWP_RET_VALUE as SWP_RET_VALUE', array());
        if($result[0]->SWP_RET_VALUE > -1)
          echo "ok";
        else{
          http_response_code(400);
          echo $result[0]->v_Success;
        }

        $_POST["BankRecStartDate"] = date("Y-m-d H:i:s", strtotime($_POST["BankRecStartDate"]));
        $_POST["BankRecEndDate"] = date("Y-m-d H:i:s", strtotime($_POST["BankRecEndDate"]));
        $form = array();
        foreach ($_POST as $key => $value) {
            $form[$key] = $value;
        }
        $values = array_merge($this->getBalance($_POST), $form);
        
        DB::statement("CALL Bank_CreateReconciliationSummary(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,@SWP_RET_VALUE)", array(
            $user["CompanyID"],
            $user["DivisionID"],
            $user["DepartmentID"],
            $values["GLBankAccount"],
            $values["CurrencyID"],
            $values["CurrencyExchangeRate"],
            $values["BankRecEndDate"],
            floatval($values["BankRecEndingBalance"]),
            floatval($values["BankRecServiceCharge"]),
            $values["GLServiceChargeAccount"],
            floatval($values["BankRecIntrest"]),
            $values["GLInterestAccount"],
            floatval($values["BankRecAdjustment"]),
            $values["GLAdjustmentAccount"],
            floatval($values["BankRecOtherCharges"]),
            $values["GLOtherChargesAccount"],
            floatval($values["TotalCredits"]),
            floatval($values["TotalDebits"]),
            floatval($values["CreditsOS"]),
            floatval($values["DebitsOS"]),
            floatval($values["Bank"]),
            floatval($values["Book"]),
            floatval($values["Unreconciled"]),
            floatval($values["EndBookBalance"]),
            floatval($values["Bank"]),
            $values["BankRecNotes"]));
    }
}
?>
