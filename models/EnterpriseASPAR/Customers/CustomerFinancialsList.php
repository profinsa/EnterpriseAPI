<?php
/*
  Name of Page: CustomerFinancialsList model
   
  Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerFinancialsList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/CustomerFinancialsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerFinancialsList.php
  used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerFinancialsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 06/07/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";

class CustomerFinancialsList extends gridDataSource{
    public $tableName = "customerfinancials";
    public $dashboardTitle ="Customer Financials";
    public $breadCrumbTitle ="Customer Financials";
    public $idField ="CustomerID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID"];
    public $modes = ["grid", "view"];
    public $gridFields = [
        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "BookedOrders" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "CurrentARBalance" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "SalesYTD" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "PaymentsYTD" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "InvoicesYTD" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "LastSalesDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "AvailibleCredit" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
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
                "inputType" => "text",
                "format" => "{0:n}",
                "defaultValue" => ""
            ],
            "HighestCredit" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "format" => "{0:n}",
                "defaultValue" => ""
            ],
            "HighestBalance" => [
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
            "BookedOrders" => [
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
            "TotalAR" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrentARBalance" => [
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
                "inputType" => "text",
                "format" => "{0:n}",
                "defaultValue" => ""
            ],
            "SalesYTD" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "format" => "{0:n}",
                "defaultValue" => ""
            ],
            "SalesLastYear" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SalesLifetime" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LastSalesDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "PaymentsLastYear" => [
                "format" => "{0:n}",
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PaymentsLifetime" => [
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
            "WriteOffsYTD" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WriteOffsLastYear" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WriteOffsLifetime" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "InvoicesYTD" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "InvoicesLastYear" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "InvoicesLifetime" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CreditMemos" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LastCreditMemoDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "CreditMemosYTD" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CreditMemosLastYear" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CreditMemosLifetime" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RMAs" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LastRMADate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "RMAsYTD" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RMAsLastYear" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RMAsLifetime" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "CustomerID" => "Customer ID",
        "BookedOrders" => "Booked Orders",
        "CurrentARBalance" => "AR Balance",
        "SalesYTD" => "Sales YTD",
        "PaymentsYTD" => "Payments YTD",
        "InvoicesYTD" => "Invoices YTD",
        "LastSalesDate" => "Last Sales Date",
        "AvailibleCredit" => "Available Credit",
        "LateDays" => "Late Days",
        "AverageDaytoPay" => "Average Day to Pay",
        "LastPaymentDate" => "Last Payment Date",
        "LastPaymentAmount" => "Last Payment Amount",
        "HighestCredit" => "Highest Credit",
        "HighestBalance" => "Highest Balance",
        "PromptPerc" => "Prompt Perc",
        "AdvertisingDollars" => "Advertising Dollars",
        "TotalAR" => "Total AR",
        "Under30" => "Under 30",
        "Over30" => "Over 30",
        "Over60" => "Over 60",
        "Over90" => "Over 90",
        "Over120" => "Over 120",
        "Over150" => "Over 150",
        "Over180" => "Over 180",
        "SalesLastYear" => "Sales Last Year",
        "SalesLifetime" => "Sales Lifetime",
        "PaymentsLastYear" => "Payments Last Year",
        "PaymentsLifetime" => "Payments Lifetime",
        "WriteOffsYTD" => "Write Offs YTD",
        "WriteOffsLastYear" => "Write Offs Last Year",
        "WriteOffsLifetime" => "Write Offs Lifetime",
        "InvoicesLastYear" => "Invoices Last Year",
        "InvoicesLifetime" => "Invoices Lifetime",
        "CreditMemos" => "Credit Memos",
        "LastCreditMemoDate" => "Last Credit Memo Date",
        "CreditMemosYTD" => "Credit Memos YTD",
        "CreditMemosLastYear" => "Credit Memos Last Year",
        "CreditMemosLifetime" => "Credit Memos Life time",
        "RMAs" => "RMAs",
        "LastRMADate" => "Last RMA Date",
        "RMAsYTD" => "RMAs YTD",
        "RMAsLastYear" => "RMAs Last Year",
        "RMAsLifetime" => "RMAs Life time",
		"CustomerName" => "Customer Name",
		"CustomerPhone" => "Customer Phone",
		"CustomerEmail" => "Customer Email"
    ];

    public $customerCategories = [
        "Main" => [
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
			"CustomerSex" => [
				"dbType" => "char(1)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CustomerBornDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"CustomerNationality" => [
				"dbType" => "varchar(15)",
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
			"CustomerWebPage" => [
				"dbType" => "varchar(80)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CustomerLogin" => [
				"dbType" => "varchar(60)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CustomerPassword" => [
				"dbType" => "varchar(20)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CustomerPasswordOld" => [
				"dbType" => "varchar(15)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CustomerPasswordDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"CustomerPasswordExpires" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"CustomerPasswordExpiresDate" => [
				"dbType" => "int(11)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CustomerFirstName" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CustomerLastName" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CustomerSalutation" => [
				"dbType" => "varchar(10)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CustomerSpeciality" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"Attention" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CustomerTypeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"TaxIDNo" => [
				"dbType" => "varchar(20)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"VATTaxIDNumber" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"VatTaxOtherNumber" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			]
		]
    ];
    
    //getting customer information record 
    public function getCustomerInfo($id, $type){
        $user = Session::get("user");
        $columns = [];
        foreach($this->customerCategories[$type] as $key=>$value){
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

        $result = DB::select("SELECT " . implode(",", $columns) . " from customerinformation" . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true)[0];
        
        return $result;        
    }

    public function getEditItem($id, $type){
        $user = Session::get("user");
        
        $keyValues = explode("__", $id);
        $result = DB::statement("CALL CustomerFinancials_ReCalc('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $keyValues[3] . "', @ret)");

        return parent::getEditItem($id, $type);
    }
}
?>
