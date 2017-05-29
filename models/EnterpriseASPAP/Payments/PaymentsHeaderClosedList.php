<?php

/*
Name of Page: PaymentsHeaderClosedList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Payments\PaymentsHeaderClosedList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PaymentsHeaderClosedList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Payments\PaymentsHeaderClosedList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Payments\PaymentsHeaderClosedList.php
 
Calls:
MySql Database
 
Last Modified: 04/13/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    protected $tableName = "paymentsheader";
    protected $gridConditions = "(IFNULL(PaymentsHeader.Posted,0)=1) AND (IFNULL(PaymentsHeader.Paid,0)=1)";
    public $dashboardTitle ="Closed Payments";
    public $breadCrumbTitle ="Closed Payments";
    public $idField ="PaymentID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentID"];
    public $gridFields = [
        "PaymentID" => [
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
        "InvoiceNumber" => [
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
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "Cleared" => [
            "dbType" => "tinyint(1)",
            "inputType" => "text"
        ],
        "Posted" => [
            "dbType" => "tinyint(1)",
            "inputType" => "text"
        ],
        "Reconciled" => [
            "dbType" => "tinyint(1)",
            "inputType" => "text"
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
            "BatchControlNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Vendor" => [
            "VendorID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Approval" => [
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
                "format" => "{0:d}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "UnAppliedAmount" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:d}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CreditAmount" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:d}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BatchControlTotal" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:d}",
                "inputType" => "text",
                "defaultValue" => ""
            ],

            "PaymentID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PaymentTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
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
                "inputType" => "text",
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
        "Payment Type ID" => "PaymentTypeID"
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
        $user = $_SESSION["user"];
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
        
        $result = $GLOBALS["DB"]::select("SELECT " . implode(",", $fields) . " from vendorinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($id ? $result[0] : $result), true);
        
        return $result;
    }

    public function getVendors(){
        $user = $_SESSION["user"];
        $keyFields = "";
        $fields = [];

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
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = $GLOBALS["DB"]::select("SELECT * from vendorinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true);
        
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
        $user = $_SESSION["user"];
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

        
        $result = $GLOBALS["DB"]::select("SELECT " . implode(",", $fields) . " from paymentsdetail " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function detailDelete(){
        $user = $_SESSION["user"];
        $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentsID", "PaymentDetailID"];
        $keyValues = explode("__", $_GET["item"]);
        $keyFields = "";
        $fcount = 0;
        foreach($idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        $GLOBALS["DB"]::delete("DELETE from paymentsdetail " .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }
}
?>
