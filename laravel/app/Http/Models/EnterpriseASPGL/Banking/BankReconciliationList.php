<?php
namespace App\Models;
require __DIR__ . "/../../../Models/gridDataSource.php";

use Illuminate\Support\Facades\DB;
use Session;

class gridData extends gridDataSource{
    protected $tableName = "bankreconciliation";
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
        "BankRecIntrest" => "Bank RecI ntrest",
        "GLInterestAccount" => "GL Interest Account",
        "BankRecOtherCharges" => "Other Charges",
        "GLOtherChargesAccount" => "GL Other Charges Account",
        "BankRecAdjustment" => "Adjustment",
        "GLAdjustmentAccount" => "GL Adjustment Account",
        "BankRecNotes" => "Notes",
        "Signature" => "Signature",
        "SignaturePassword" => "SignaturePassword",
        "SupervisorSignature" => "SupervisorSignature",
        "SupervisorPassword" => "SupervisorPassword",
        "ManagerSignature" => "ManagerSignature",
        "ManagerPassword" => "ManagerPassword",
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
    public function getCreditsPage(){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->creditsFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->idFields as $key){
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

        if(property_exists($this, "gridConditions")){
            if($keyFields != "")
                $keyFields .= " AND " . $this->gridConditions;
            else
                $keyFields = $this->gridConditions;
        }
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from BankReconciliationDetailCredits" . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }



    public $debitsFields = [
        "BankRecDocumentNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
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
    public function getDebitsPage(){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->debitsFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->idFields as $key){
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

        if(property_exists($this, "gridConditions")){
            if($keyFields != "")
                $keyFields .= " AND " . $this->gridConditions;
            else
                $keyFields = $this->gridConditions;
        }
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from BankReconciliationDetailDebits" . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
}
?>
