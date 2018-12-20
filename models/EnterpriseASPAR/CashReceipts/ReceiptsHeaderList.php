<?php
/*
  Name of Page: ReceiptsHeaderList model
   
  Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\CashReceipts\ReceiptsHeaderList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/ReceiptsHeaderList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\CashReceipts\ReceiptsHeaderList.php
  used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\CashReceipts\ReceiptsHeaderList.php
   
  Calls:
  MySql Database
   
  Last Modified: 12/20/2018
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";

class ReceiptsHeaderList extends gridDataSource{
    public $tableName = "receiptsheader";
    public $gridConditions = "(ReceiptsHeader.ReceiptClassID = 'Customer') AND (ReceiptsHeader.CreditAmount IS NULL OR ReceiptsHeader.CreditAmount <> 0 OR IFNULL(ReceiptsHeader.Posted,0) = 0)";
    public $dashboardTitle ="Receipts";
    public $breadCrumbTitle ="Receipts";
    public $idField ="ReceiptID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","ReceiptID"];
    public $gridFields = [
        "ReceiptID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ReceiptTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "TransactionDate" => [
            "dbType" => "timestamp",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "CurrencyID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text"
        ],
        "Amount" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ],
        "Status" => [
            "dbType" => "varchar(10)",
            "inputType" => "text"
        ],
        "Deposited" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ],
        "Cleared" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ],
        "Reconciled" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ],
        "Posted" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "TransactionDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "SystemDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "DueToDate" => [
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
                "defaultValue" => "",
                "dataProvider" => "getAccounts"
            ],
            "Status" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NSF" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Notes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
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
            ]
        ],
        "Customer" => [
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => "",
                "defaultOverride" => "true",
                "required" => "true",
                "defaultValue" => ""
            ]
        ],
		"Memos" => [
            "HeaderMemo1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo4" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo5" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo6" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo7" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo8" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo9" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "...fields" => [
            "ReceiptID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => "(new)",
                "dirtyAutoincrement" => "true"
            ],
            "ReceiptTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getReceiptTypes",
                "defaultValue" => ""
            ],
            "ReceiptClassID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledNew" => "true",
                "disabledEdit" => "true",
                "defaultValue" => "",
                "defaultOverride" => true,
				"defaultValue" => "Customer"
            ],
            "CheckNumber" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "defaultValue" => "",
                "defaultOverride" => "true",
                "required" => "true",
                "inputType" => "dialogChooser",
                "dataProvider" => "getCustomers",
                "defaultValue" => ""
            ],
            "Memorize" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "TransactionDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "SystemDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "DueToDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "OrderDate" => [
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
            "Amount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "UnAppliedAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "GLBankAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "Status" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NSF" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Notes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CreditAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "Cleared" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Posted" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Reconciled" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Deposited" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "HeaderMemo1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo4" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo5" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo6" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo7" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo8" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo9" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
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
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
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
            ]
        ]
    ];

    public $headTableOne = [
        "Receipt ID" => "ReceiptID",
        "Receipt Type" => "ReceiptTypeID",
        "Receipt Class ID" => "ReceiptClassID",
    ];

    public $headTableTwo = [
        "Check Number" => "CheckNumber",
        "Customer ID" => "CustomerID",
        "Order Date" => "OrderDate"
    ];

    public $detailTable = [
        "viewPath" => "AccountsReceivable/CashReceiptsProcessing/ViewCashReceiptsDetail",
        "newKeyField" => "ReceiptID",
        "keyFields" => ["ReceiptID", "ReceiptDetailID"]
    ];

    public $footerTable = [
        "flagsHeader" => [
            "Posted" => "Posted",
            "Memorized" => "Memorize"
        ],
        "flags" => [
            ["Cleared", "Cleared"],
            ["Reconciled", "Reconciled"],
            ["Deposited", "Deposited"],
            ["Approved", "Approved", "ApprovedDate", "Approved Date"]
        ],
        "totalFields" => [
            "Batch Control Total" => "BatchControlTotal",
            "UnApplied Amount" => "UnAppliedAmount",
            "Credit Amount" => "CreditAmount",
            "Amount" => "Amount"
        ]
    ];

    public $columnNames = [
        "ReceiptID" => "Receipt ID",
        "ReceiptTypeID" => "Receipt Type",
        "CustomerID" => "Customer ID",
        "TransactionDate" => "Transaction Date",
        "CurrencyID" => "Currency ID",
        "Amount" => "Amount",
        "Status" => "Status",
        "Deposited" => "Deposited",
        "Cleared" => "Cleared",
        "Reconciled" => "Reconciled",
        "Posted" => "Posted",
        "ReceiptClassID" => "Receipt Class ID",
        "CheckNumber" => "Check Number",
        "Memorize" => "Memorize",
        "SystemDate" => "System Date",
        "DueToDate" => "Due To Date",
        "OrderDate" => "Order Date",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "UnAppliedAmount" => "UnApplied Amount",
        "GLBankAccount" => "GL Bank Account",
        "NSF" => "NSF",
        "Notes" => "Notes",
        "CreditAmount" => "Credit Amount",
        "HeaderMemo1" => "Memo 1",
        "HeaderMemo2" => "Memo 2",
        "HeaderMemo3" => "Memo 3",
        "HeaderMemo4" => "Memo 4",
        "HeaderMemo5" => "Memo 5",
        "HeaderMemo6" => "Memo 6",
        "HeaderMemo7" => "Memo 7",
        "HeaderMemo8" => "Memo 8",
        "HeaderMemo9" => "Memo 9",
        "Approved" => "Approved",
        "ApprovedBy" => "Approved By",
        "ApprovedDate" => "Approved Date",
        "EnteredBy" => "Entered By",
        "BatchControlNumber" => "Batch Control Number",
        "BatchControlTotal" => "Batch Control Total",
        "Signature" => "Signature",
        "SignaturePassword" => "Signature Password",
        "SupervisorSignature" => "Supervisor Signature",
        "SupervisorPassword" => "Supervisor Password",
        "ManagerSignature" => "Manager Signature",
        "ManagerPassword" => "Manager Password",
 		"DocumentNumber" => "Doc Number",
		"DocumentDate" => "Doc Date",
        "AppliedAmount" => "Amount",
		"ProjectID" => "ProjectID"
    ];

    public $customerFields = [
        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "AccountStatus" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerAddress1" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerAddress2" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerAddress3" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerCity" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerState" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerZip" => [
            "dbType" => "varchar(10)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerCountry" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerPhone" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerFax" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerEmail" => [
            "dbType" => "varchar(60)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "Attention" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $customerIdFields = ["CompanyID","DivisionID","DepartmentID","CustomerID"];
    //getting data for Customer Page
    public function getCustomerInfo($id){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->customerFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->customerIdFields as $key){
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

        if($id)
            $keyFields .= " AND CustomerID='" . $id . "'";
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from customerinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($id ? $result[0] : $result), true);
        
        return $result;
    }


    public $detailIdFields = ["CompanyID","DivisionID","DepartmentID","ReceiptID", "ReceiptDetailID"];
	public $embeddedgridFields = [
		"DocumentNumber" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"DocumentDate" => [
			"dbType" => "datetime",
			"inputType" => "datetime"
		],
        "AppliedAmount" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
		"ProjectID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		]
	];
    
    //getting rows for grid
    public function getDetail($id){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->embeddedgridFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailIdFields as $key){
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
        $keyFields .= " AND ReceiptID='" . $id . "'";
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from receiptsdetail " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());
        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
    
    public function detailDelete(){
        $user = Session::get("user");
        $idFields = ["CompanyID","DivisionID","DepartmentID","ReceiptID", "ReceiptDetailID"];
        $keyValues = explode("__", $_GET["item"]);
        $keyFields = "";
        $fcount = 0;
        foreach($idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        DB::delete("DELETE from receiptsdetail " .   ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());
    }

    public function Recalc(){
        $user = Session::get("user");

        DB::statement("CALL Receipt_Recalc2('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["ReceiptID"] . "',@SWP_RET_VALUE)", array());

        $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
        if($result[0]->SWP_RET_VALUE == -1)
            http_response_code(400);
            
        echo $result[0]->SWP_RET_VALUE;
    }
    
    public function Post(){
        $user = Session::get("user");
        
        DB::statement("CALL Receipt_Post2('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["ReceiptID"] . "',@Success,@PostingResult,@SWP_RET_VALUE)", array());
        
        $result = DB::select('select @PostingResult as PostingResult, @SWP_RET_VALUE as SWP_RET_VALUE', array());
        if($result[0]->SWP_RET_VALUE == -1){
            http_response_code(400);
            echo $result[0]->PostingResult;
        }else
            echo $result[0]->SWP_RET_VALUE;
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
        DB::update("UPDATE " . $this->tableName . " set Memorize='" . ($_POST["Memorize"] == '1' ? '0' : '1') . "' WHERE ". $keyFields, array());
        echo "ok";
    }
}

class gridData extends ReceiptsHeaderList {}

class ReceiptsHeaderClosedList extends ReceiptsHeaderList{
    public $gridConditions = "(ReceiptsHeader.ReceiptClassID = 'Customer') AND (NOT (ReceiptsHeader.CreditAmount IS NULL OR ReceiptsHeader.CreditAmount <> 0)) AND IFNULL(ReceiptsHeader.Posted,0) = 1";
    public $dashboardTitle ="Closed Receipt";
    public $breadCrumbTitle ="Closed Receipt";
    public $modes = ["grid", "view", "edit"]; // list of enabled modes
    public $features = ["selecting"]; //list enabled features

    public function CopyToHistory(){
        $user = Session::get("user");

        $numbers = explode(",", $_POST["ReceiptIDs"]);
        $success = true;
        foreach($numbers as $number){
            DB::statement("CALL Receipt_CopyToHistory2('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $number . "',@SWP_RET_VALUE)", array());

            $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
            if($result[0]->SWP_RET_VALUE == -1)
                $success = false;
        }

        if(!$success)
            http_response_status(400);

        echo $result[0]->SWP_RET_VALUE;
    }
    
    public function CopyAllToHistory(){
        $user = Session::get("user");

        //        echo json_encode($_POST, JSON_PRETTY_PRINT);
        $items = DB::select("select " . $this->idField . " from " . $this->tableName . " WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?" . (property_exists($this, "gridConditions") ? " AND " . $this->gridConditions : ""), [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);

        $idField = $this->idField;
        foreach($items as $item)
            DB::statement("CALL Receipt_CopyToHistory2(?, ?, ?, ?,@SWP_RET_VALUE)", array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $item->$idField));

        //we using iteration and call CopyToHistory2 because of CopyAllToHistory is broken
        /*        DB::statement("CALL Receipt_CopyAllToHistory('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "', @SWP_RET_VALUE)", array());

        $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
        if($result[0]->SWP_RET_VALUE <= -1)
            http_response_status(400);
            echo $result[0]->SWP_RET_VALUE;*/
        echo "ok";
    }
}
?>
