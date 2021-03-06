<?php
/*
  Name of Page: VendorFinancialsList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorFinancialsList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/VendorFinancialsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorFinancialsList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorFinancialsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 06/07/2019
  Last Modified by: Zaharov Nikita
*/


require "./models/gridDataSource.php";
class VendorFinancialsList extends gridDataSource{
    public $tableName = "vendorfinancials";
    public $dashboardTitle ="Vendor Financials";
    public $breadCrumbTitle ="Vendor Financials";
    public $idField ="VendorID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID"];
    public $modes = ["view", "grid"];
    public $gridFields = [
        "VendorID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "BookedPurchaseOrders" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "CurrentAPBalance" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "PurchaseYTD" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "PaymentsYTD" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "LastPurchaseDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "VendorID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "LateDays" => [
                "dbType" => "smallint(6)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AverageDaytoPay" => [
                "dbType" => "smallint(6)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LastPaymentDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "LastPaymentAmount" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HighestCredit" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HighestBalance" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AvailableCredit" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PromptPerc" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BookedPurchaseOrders" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AdvertisingDollars" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TotalAP" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrentAPBalance" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Under30" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Over30" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Over60" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Over90" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Over120" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Over150" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Over180" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LastPurchaseDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "PurchaseYTD" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PurchaseLastYear" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PurchaseLifetime" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PaymentsYTD" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PaymentsLastYear" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PaymentsLifetime" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DebitMemos" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LastDebitMemoDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "DebitMemosYTD" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DebitMemosLastYear" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DebitMemosLifetime" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorReturns" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LastReturnDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ReturnsYTD" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ReturnsLastYear" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ReturnsLifetime" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "VendorID" => "Vendor ID",
        "BookedPurchaseOrders" => "Booked Orders",
        "CurrentAPBalance" => "AP Balance",
        "PurchaseYTD" => "Purchase YTD",
        "PaymentsYTD" => "Payments YTD",
        "LastPurchaseDate" => "Last Purchase Date",
        "LateDays" => "Late Days",
        "AverageDaytoPay" => "Average Day to Pay",
        "LastPaymentDate" => "Last Payment Date",
        "LastPaymentAmount" => "Last Payment Amount",
        "HighestCredit" => "Highest Credit",
        "HighestBalance" => "Highest Balance",
        "AvailableCredit" => "Available Credit",
        "PromptPerc" => "Prompt Perc",
        "AdvertisingDollars" => "Advertising Dollars",
        "TotalAP" => "Total AP",
        "Under30" => "Under 30",
        "Over30" => "Over 30",
        "Over60" => "Over 60",
        "Over90" => "Over 90",
        "Over120" => "Over 120",
        "Over150" => "Over 150",
        "Over180" => "Over 180",
        "PurchaseLastYear" => "Purchase Last Year",
        "PurchaseLifetime" => "Purchase Lifetime",
        "PaymentsLastYear" => "Payments Last Year",
        "PaymentsLifetime" => "Payments Lifetime",
        "DebitMemos" => "Debit Memos",
        "LastDebitMemoDate" => "Last Debit Memo Date",
        "DebitMemosYTD" => "Debit Memos YTD",
        "DebitMemosLastYear" => "Debit Memos Last Year",
        "DebitMemosLifetime" => "Debit Memos Lifetime",
        "VendorReturns" => "Vendor Returns",
        "LastReturnDate" => "Last Return Date",
        "ReturnsYTD" => "Returns YTD",
        "ReturnsLastYear" => "Returns Last Year",
        "ReturnsLifetime" => "Returns Lifetime",
		"VendorName" => "Vendor Name",
		"VendorEmail" => "Vendor Email",
		"VendorLogin" => "Vendor Login",
		"VendorPassword" => "Vendor Password",
		"AccountStatus" => "Account Status",
		"VendorAddress1" => "Vendor Address 1",
		"VendorAddress2" => "Vendor Address 2",
		"VendorAddress3" => "Vendor Address 3",
		"VendorCity" => "Vendor City",
		"VendorState" => "Vendor State",
		"VendorZip" => "Vendor Zip",
		"VendorCountry" => "Vendor Country",
		"VendorPhone" => "Vendor Phone",
		"VendorFax" => "Vendor Fax"
    ];

    public $vendorCategories = [
		"Main" => [
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
			"VendorLogin" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"VendorPassword" => [
                "dbType" => "varchar(15)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"VendorPasswordOld" => [
                "dbType" => "varchar(15)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"VendorPasswordDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
			],
			"VendorPasswordExpires" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
			],
			"VendorPasswordExpiresDate" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"Attention" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"VendorTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"AccountNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"ContactID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
			]
		]
    ];

    //getting vendor information record 
    public function getVendorInfo($id, $type){
        $user = $_SESSION["user"];
        $columns = [];
        foreach($this->vendorCategories[$type] as $key=>$value){
            $columns[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $columns[] = $addfield;
            }
        }
        
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = $GLOBALS["capsule"]::select("SELECT " . implode(",", $columns) . " from vendorinformation" . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true)[0];
        
        return $result;        
    }

    public function getEditItem($id, $type){
        $user = Session::get("user");
        
        $keyValues = explode("__", $id);
        $result = DB::statement("SELECT @ret = VendorFinancials_ReCalc2('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $keyValues[3] . "')");

        return parent::getEditItem($id, $type);
    }
}
?>
