<?php
/*
  Name of Page: PaymentsHeaderList model
   
  Method: Model for gridView. It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Zaharov Nikita
   
  Use: this model used by views/PaymentsHeaderList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAP\Payments\PaymentsHeaderList.php
  used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAP\Payments\PaymentsHeaderList.php
   
  Calls:
  MySql Database
   
  Last Modified: 19/11/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class PaymentsHeaderList extends gridDataSource{
    public $tableName = "paymentsheader";
    public $gridConditions = "(IFNULL(PaymentsHeader.Posted,0)=0 OR IFNULL(PaymentsHeader.Paid,0)=0) AND PaymentID <> 'DEFAULT'";
    public $dashboardTitle ="Payments";
    public $breadCrumbTitle ="Payments";
    public $docType = "payment";
    public $idField ="PaymentID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentID"];
    public $gridFields = [
        "PaymentID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "InvoiceNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "PaymentTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "CheckNumber" => [
            "dbType" => "varchar(20)",
            "inputType" => "text"
        ],
        "VendorID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "VendorInvoiceNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "PaymentDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "CurrencyID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text"
        ],
        "Amount" => [
            "dbType" => "decimal(19,4)",
            "formatFunction" => "currencyFormat",
            "inputType" => "text"
        ],
        "Cleared" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ],
        "Posted" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ],
        "Reconciled" => [
            "dbType" => "tinyint(1)",
            "inputType" => "chechbox"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "VendorInvoiceNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CheckNumber" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PaymentClassID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PurchaseDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "GLBankAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PaymentStatus" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Notes" => [
                "dbType" => "varchar(255)",
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
           "InvoiceNumber" => [
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
        "Vendor" => [
            "loadFrom" => [
                "method" => "getVendorInfo",
                "key" => "VendorID",
            ],
            "VendorID" => [
                "dbType" => "varchar(50)",
                "defaultValue" => "",
                "defaultOverride" => "true",
                "required" => "true",
                "inputType" => "text"
            ],
            "AccountStatus" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorName" => [
                "title" => "Name",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorAddress1" => [
                "title" => "addr 1",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorAddress2" => [
                "title" => "addr 2",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorAddress3" => [
                "title" => "addr 3",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorCity" => [
                "title" => "City",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorState" => [
                "title" => "State",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorZip" => [
                "title" => "Zip",
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorCountry" => [
                "title" => "Country",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorPhone" => [
                "title" => "Phone",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorFax" => [
                "title" => "Fax",
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorEmail" => [
                "title" => "Email",
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorWebPage" => [
                "title" => "Web",
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Attention" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Approval" => [
            "ApprovedBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
                "defaultValue" => ""
            ],
            "EnteredBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
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
        ],
        "...fields" => [
            "Void" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "CheckPrinted" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "CheckDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "Paid" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "PaymentDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "Memorize" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Cleared" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SelectedForPayment" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SelectedForPaymentDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ApprovedForPayment" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApprovedForPaymentDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
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
            "Credit" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],

            "Amount" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "UnAppliedAmount" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CreditAmount" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BatchControlTotal" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PaymentID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => "(new)",
                "dirtyAutoincrement" => "true"
            ],
            "PaymentTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getPaymentTypes",
                "defaultValue" => ""
            ],
            "VendorInvoiceNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CheckNumber" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PaymentClassID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorID" => [
                "dbType" => "varchar(50)",
                "required" => "true",
                "defaultOverride" => true,
                "inputType" => "dialogChooser",
                "dataProvider" => "getVendors",
                "defaultValue" => ""
            ],
            "DueToDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "PurchaseDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "GLBankAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PaymentStatus" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Notes" => [
                "dbType" => "varchar(255)",
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
            "InvoiceNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ApprovedBy" => [
                "dbType" => "varchar(36)",
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
        ]
    ];
    public $columnNames = [
        "PaymentID" => "Payment ID",
        "InvoiceNumber" => "Purchase Number",
        "PaymentTypeID" => "Payment Type",
        "CheckNumber" => "Check Number",
        "VendorID" => "Vendor ID",
        "VendorInvoiceNumber" => "Vendor Invoice Number",
        "PaymentDate" => "Payment Date",
        "CurrencyID" => "Currency ID",
        "Amount" => "Amount",
        "Cleared" => "Cleared",
        "Posted" => "Posted",
        "Reconciled" => "Reconciled",
        "CheckPrinted" => "Check Printed",
        "CheckDate" => "Check Date",
        "Paid" => "Paid",
        "Memorize" => "Memorize",
        "PaymentClassID" => "Payment Class ID",
        "SystemDate" => "System Date",
        "DueToDate" => "Due To Date",
        "PurchaseDate" => "Purchase Date",
        "UnAppliedAmount" => "UnApplied Amount",
        "GLBankAccount" => "GL Bank Account",
        "PaymentStatus" => "Payment Status",
        "Void" => "Void",
        "Notes" => "Notes",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "CreditAmount" => "Credit Amount",
        "SelectedForPayment" => "Selected For Payment",
        "SelectedForPaymentDate" => "Selected For Payment Date",
        "ApprovedForPayment" => "Approved For Payment",
        "ApprovedForPaymentDate" => "Approved For Payment Date",
        "Credit" => "Credit",
        "ApprovedBy" => "Approved By",
        "EnteredBy" => "Entered By",
        "BatchControlNumber" => "Batch Control Number",
        "BatchControlTotal" => "Batch Control Total",
        "Signature" => "Signature",
        "SignaturePassword" => "Signature Password",
        "SupervisorSignature" => "Supervisor Signature",
        "SupervisorPassword" => "Supervisor Password",
        "ManagerSignature" => "Manager Signature",
        "ManagerPassword" => "Manager Password",
        "OrderQty" => "Qty",
        "ItemID" => "Item ID",
        "Description" => "Description",
        "ItemUOM" => "UOM",
        "ItemUnitPrice" => "Price",
        "Total" => "Total",
        "GLPurchaseAccount" => "Purchase Account",
        "ProjectID" => "ProjectID",
        "VendorID" => "Vendor ID",
        "AccountStatus" => "Accounts Status",
        "VendorName" => "Name",
        "VendorAddress1" => "Addr 1",
        "VendorAddress2" => "Addr 2",
        "VendorAddress3" => "Addr 3",
        "VendorCity" => "City",
        "VendorState" => "State",
        "VendorZip" => "Zip",
        "VendorCountry" => "Country",
        "VendorPhone" => "Phone",
        "VendorFax" => "Fax",
        "VendorEmail" => "Email",
        "VendorWebPage" => "Web",
        "Attention" => "Attention",
		"PayedID" => "Sub Vendor",
        "DocumentNumber" => "Doc #",
        "DocumentDate" => "Doc Date",
		"GLExpenseAccount" => "Account",
        "AppliedAmount" =>	"Amount",
		"ProjectID" => "Project ID"
    ];

    public $headTableOne = [
        "Payment ID" => "PaymentID",
        "Due Date" => "DueToDate",
        "Payment Type ID" => "PaymentTypeID",
        "Vendor ID" => "VendorID"
    ];

    public $customerField = "VendorID";
    
    public $detailTable = [
        "viewPath" => "AccountsPayable/VoucherProcessing/ViewVouchersDetail",
        "newKeyField" => "PaymentID",
        "keyFields" => ["PaymentID", "PaymentDetailID"],
    ];

    public $footerTable = [
        "flagsHeader" => [
            "Memorized" => "Memorize"
        ],
        "flags" => [
            ["Void", "Void"],
            ["Cleared", "Cleared"],
            ["Cleared", "Cleared"],
            ["Posted", "Posted"],
            ["Reconciled", "Reconciled"],
            ["Credit", "Credit"],
            ["CheckPrinted", "Check Printed", "CheckDate", "Check Date"],
            ["Paid", "Paid", "PaymentDate", "Payment Date"],
            ["SelectedForPayment", "Selected For Payment", "SelectedForPaymentDate", "Selected Date"],
            ["ApprovedForPayment", "Approved For Payment", "ApprovedForPaymentDate", "Approved Date"]
        ],
        "totalFields" => [
            "Batch Control Total" => "BatchControlTotal",
            "UnApplied Amount" => "UnAppliedAmount",
            "Credit Amount" => "CreditAmount",
            "Amount" => "Amount"
        ]
    ];

    public $vendorFields = [
        "VendorID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "AccountStatus" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorAddress1" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorAddress2" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorAddress3" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorCity" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorState" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorZip" => [
            "dbType" => "varchar(10)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorCountry" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorPhone" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorFax" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorEmail" => [
            "dbType" => "varchar(60)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "VendorWebPage" => [
            "dbType" => "varchar(80)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "Attention" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $vendorIdFields = ["CompanyID","DivisionID","DepartmentID","VendorID"];
    //getting data for Vendor Page
    public function getVendorInfo($id){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->vendorFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->vendorIdFields as $key){
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
            $keyFields .= " AND VendorID='" . $id . "'";
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from vendorinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($id ? $result[0] : $result), true);
        
        return $result;
    }

    public $detailIdFields = ["CompanyID","DivisionID","DepartmentID","PaymentID", "PaymentDetailID"];
	public $embeddedgridFields = [
		"PayedID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"DocumentNumber" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
        "DocumentDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
		"GLExpenseAccount" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
        "AppliedAmount" =>	[
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

        $keyFields .= " AND PaymentID='" . $id . "'";

        
        $result = DB::select("SELECT " . implode(",", $fields) . " from paymentsdetail " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function detailDelete(){
        $user = Session::get("user");
        $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentID", "PaymentDetailID"];
        $keyValues = explode("__", $_GET["item"]);
        $keyFields = "";
        $fcount = 0;
        foreach($idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        DB::delete("DELETE from paymentsdetail " .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }

    public function getPage($id){
        $user = Session::get("user");
        if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "duetoday"){
            $this->gridConditions .= "and DueToDate >= now() - INTERVAL 1 DAY";
            $result = parent::getPage($id);
            return $result;
        }else if(key_exists("filter", $_GET) && ($filter = $_GET["filter"]) == "duethismonth"){
            $this->gridConditions .= "and DueToDate >= now() - INTERVAL 30 DAY";
            $result = parent::getPage($id);
            return $result;
        }else{
            $result = parent::getPage($id);
            return $result;
        }
    }
    
    public function Post(){
        $user = Session::get("user");

         DB::statement("CALL Payment_Post('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["PaymentID"] . "',@Succes,@PostingResult,@SWP_RET_VALUE)");

         $result = DB::select('select @Succes as Success, @PostingResult as PostingResult, @SWP_RET_VALUE as SWP_RET_VALUE');
         if($result[0]->SWP_RET_VALUE == -1) {
             http_response_code(400);
             echo $result[0]->PostingResult;
         } else
             echo "ok";
    }

    public function Recalc(){} //nothing to recalc, may be

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
}

class gridData extends PaymentsHeaderList{}

class PaymentsHeaderVoidList extends PaymentsHeaderList{
    public $gridConditions = "(IFNULL(PaymentsHeader.Posted,0)=0 OR IFNULL(PaymentsHeader.Paid,0)=0) AND IFNULL(PaymentsHeader.Void,0)=0";
    public $dashboardTitle ="Void Vouchers";
    public $breadCrumbTitle ="Void Vouchers";
    public $modes = ["grid", "view"];

    public function Payment_Void(){
        $user = Session::get("user");

         DB::statement("CALL Payment_Void('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["PaymentID"] . "',@PostingResult,@SWP_RET_VALUE)");

         $result = DB::select('select @PostingResult as PostingResult, @SWP_RET_VALUE as SWP_RET_VALUE');
         if($result[0]->SWP_RET_VALUE == -1) {
             http_response_code(400);
             echo $result[0]->PostingResult;
         } else
             echo "ok";
    }
}

class PaymentsHeaderClosedList extends PaymentsHeaderList{
    public $gridConditions = "(IFNULL(PaymentsHeader.Posted,0)=1) AND (IFNULL(PaymentsHeader.Paid,0)=1)";
    public $dashboardTitle ="Closed Payments";
    public $breadCrumbTitle ="Closed Payments";
    public $modes = ["view", "grid", "edit"];
    public $features = ["selecting"];

    public function CopyToHistory(){
        $user = Session::get("user");

        $PaymentIDs = explode(",", $_POST["PaymentIDs"]);
        $success = true;
        foreach($PaymentIDs as $paymentID){
            DB::statement("CALL Payment_CopyToHistory2('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $paymentID . "',@SWP_RET_VALUE)");

            $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
            if($result[0]->SWP_RET_VALUE == -1)
                $success = false;
        }

        if($success)
            echo "ok";
        else{
            http_respose_code(400);
            echo $result[0]->SWP_RET_VALUE;
        }
    }
    
    public function CopyAllToHistory(){
        $user = Session::get("user");

        DB::statement("CALL Payment_CopyAllToHistory('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "', @SWP_RET_VALUE)");

        $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
        if($result[0]->SWP_RET_VALUE > -1)
            echo $result[0]->SWP_RET_VALUE;
        else{
            http_respose_code(400);
            echo $result[0]->SWP_RET_VALUE;
        }
    }
}

class PaymentsHeaderApproveList extends PaymentsHeaderList{
    public $gridConditions = "(IFNULL(ApprovedForPayment,0)=0 AND Posted=1 AND IFNULL(Void,0)=0 AND PaymentID <> 'DEFAULT')";
    public $dashboardTitle ="Approve Payments";
    public $breadCrumbTitle ="Approve Payments";
    public $modes = ["grid", "print"]; // list of enabled modes
    public $features = ["selecting"]; //list enabled features

    public function Approve(){
        $user = Session::get("user");

        $PaymentIds = explode(",", $_POST["PaymentIDs"]);
        $success = true;
        foreach($PaymentIds as $PaymentId){
            DB::statement("CALL Payment_Approve('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $PaymentId . "','" . $user["EmployeeID"] . "',@SWP_RET_VALUE)");

            $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
            if($result[0]->SWP_RET_VALUE == -1)
                $success = false;
        }

        if($success)
            echo "ok";
        else {
            http_response_code(400);
            echo "failed";
        }
    }
    
    public function ApproveAll(){
        $user = Session::get("user");

        DB::statement("CALL Payment_ApproveAll('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $user["EmployeeID"] . "',@SWP_RET_VALUE)");

        $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
        if($result[0]->SWP_RET_VALUE > -1)
            echo $result[0]->SWP_RET_VALUE;
        else {
            http_response_code(400);
            echo $result[0]->SWP_RET_VALUE;
        }
    }
}

class PaymentsHeaderIssueCreditMemoList extends PaymentsHeaderList{
    public $gridConditions = "(IFNULL(PaymentsHeader.Posted,0)=0 OR IFNULL(PaymentsHeader.Paid,0)=0) AND PaymentsHeader.ApprovedForPayment=1 AND IFNULL(PaymentsHeader.Void,0)=0 AND PaymentsHeader.PaymentID <> 'DEFAULT'";
    public $modes = ["grid"];
    public $features = ["selecting"];
    public $dashboardTitle ="Issue Credit Memo For Payments";
    public $breadCrumbTitle ="Issue Credit Memo For Payments";

    public function Payment_CreateCreditMemo(){
        $user = Session::get("user");

        $PaymentIds = explode(",", $_POST["PaymentIDs"]);
        $success = true;
        foreach($PaymentIds as $PaymentId){
            DB::statement("CALL Payment_CreateCreditMemo('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $PaymentId . "',@SWP_RET_VALUE)");

            $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
            if($result[0]->SWP_RET_VALUE == -1)
                $success = false;
        }

        if($success)
            echo "ok";
        else{
            http_response_code(400);
            echo "Credit Memo creating failed";
        }
    }
    
    public function Payment_CreateCreditMemoForAll(){
        $user = Session::get("user");

        DB::statement("CALL Payment_CreateCreditMemoForAll('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@SWP_RET_VALUE)");

        $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
        if($result[0]->SWP_RET_VALUE > -1)
            echo $result[0]->SWP_RET_VALUE;
        else{
            http_response_code(400);
            echo $result[0]->SWP_RET_VALUE;
        }
    }
}

class PaymentsHeaderIssueList extends PaymentsHeaderList{
    public $tableName = "paymentsheader";
    public $gridConditions = "(IFNULL(ApprovedForPayment,0) = 1 AND IFNULL(CheckPrinted,0) = 0 AND IFNULL(Posted,0) = 1 AND IFNULL(Paid,0) = 0)";
    public $dashboardTitle ="Issue Payments for Vouchers";
    public $breadCrumbTitle ="Issue Payments for Vouchers";
    public $modes = ["grid"];
    public $features = ["selecting"];

    public $editCategories = [
        "Main" => [
            "PaymentID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => true,
            ],
            "InvoiceNumber" => [
                "dbType" => "varchar(36)",
                "disabledEdit" => true,
                "inputType" => "text"
            ],
            "PaymentTypeID" => [
                "dbType" => "varchar(36)",
                "disabledEdit" => true,
                "inputType" => "text"
            ],
            "CheckNumber" => [
                "dbType" => "varchar(20)",
                "disabledEdit" => true,
                "inputType" => "text"
            ],
            "VendorID" => [
                "dbType" => "varchar(50)",
                "disabledEdit" => true,
                "inputType" => "text"
            ],
            "PaymentDate" => [
                "dbType" => "datetime",
                "format" => "{0:d}",
                "disabledEdit" => true,
                "inputType" => "datetime"
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "disabledEdit" => true,
                "inputType" => "text"
            ],
            "Amount" => [
                "dbType" => "decimal(19,4)",
                "formatFunction" => "currencyFormat",
                "inputType" => "text"
            ]
        ]
    ];

    
    public function Process(){
        $user = Session::get("user");

        //PaymentCheck_CheckRun
        $PaymentIds = explode(",", $_POST["PaymentIDs"]);
        $success = true;
        foreach($PaymentIds as $PaymentId){
            DB::statement("CALL PaymentCheck_PrintInsert(?, ?, ?, ?, ?,@SWP_RET_VALUE)", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $user["EmployeeID"], $PaymentId]);

            $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
            if($result[0]->SWP_RET_VALUE == -1)
                $success = false;
        }

        if($success){
            DB::statement("CALL PaymentCheck_Run(?, ?, ?, ?,@SWP_RET_VALUE)", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $user["EmployeeID"]]);

            $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
            if($result[0]->SWP_RET_VALUE == -1)
                $success = false;
            if($success)
                echo "ok";
            else{
                http_response_code(400);
                echo "Processing Check failed";
            }
        }else{
            http_response_code(400);
            echo "Processing Check failed";
        }
    }

    public function PaymentCheck_PostAllChecks(){
        $user = Session::get("user");

        DB::statement("CALL PaymentCheck_PostAllChecks(?, ?, ?, ?, @SWP_RET_VALUE)", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $user["EmployeeID"]]);

        $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
        if($result[0]->SWP_RET_VALUE > -1)
            echo $result[0]->SWP_RET_VALUE;
        else{
            http_response_code(400);
            echo $result[0]->SWP_RET_VALUE;
        }
    }

    public function Payment_Split(){
        $user = Session::get("user");

        DB::statement("CALL Payment_Split(?, ?, ?, ?, ?,@SWP_RET_VALUE)", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $_POST["PaymentID"], $_POST["Amount"]]);

        $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
        if($result[0]->SWP_RET_VALUE == -1){
            http_response_code(400);
            echo "Payment spliting failed";
        }else
             echo "ok";
    }
}
?>

