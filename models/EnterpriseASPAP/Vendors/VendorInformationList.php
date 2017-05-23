<?php

/*
Name of Page: VendorInformationList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorInformationList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/VendorInformationList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorInformationList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorInformationList.php
 
Calls:
MySql Database
 
Last Modified: 04/13/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
	protected $tableName = "vendorinformation";
	public $dashboardTitle ="Vendors Information";
	public $breadCrumbTitle ="Vendors Information";
	public $idField ="VendorID";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID"];
	public $gridFields = [
		"VendorID" => [
			"dbType" => "varchar(50)",
			"inputType" => "text"
		],
		"VendorTypeID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"VendorName" => [
			"dbType" => "varchar(50)",
			"inputType" => "text"
		],
		"VendorEmail" => [
			"dbType" => "varchar(60)",
			"inputType" => "text"
		],
		"VendorLogin" => [
			"dbType" => "varchar(60)",
			"inputType" => "text"
		],
		"VendorPassword" => [
			"dbType" => "varchar(15)",
			"inputType" => "text"
		]
	];

	public $editCategories = [
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
		],
		"Remittance" => [
			"RemittToName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"RemittToAddress1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"RemittToAddress2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"RemittToAddress3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"RemittToCity" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"RemittToState" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"RemittToZip" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"RemittToCountry" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"RemittToPhone" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"RemittToFax" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"RemittToEmail" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"RemittToWebsite" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"RemittToNotes" => [
                "dbType" => "varchar(250)",
                "inputType" => "text",
                "defaultValue" => ""
			]
		],
		"Defaults" => [
			"ShipMethodID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"WarehouseID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"PriceMatrix" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"PriceMatrixCurrent" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
			],
			"CurrencyID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"TermsID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"TermsStart" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"GLPurchaseAccount" => [
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
			],
			"TaxGroupID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"CreditLimit" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"AvailibleCredit" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"CreditComments" => [
                "dbType" => "varchar(250)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"CreditRating" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"ApprovalDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
			],
			"CustomerSince" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
			],
			"FreightPayment" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"CustomerSpecialInstructions" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"SpecialTerms" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"Vendor1099" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
			]
		],
		"EDI" => [
			"EDIQualifier" => [
                "dbType" => "varchar(2)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"EDIID" => [
                "dbType" => "varchar(12)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"EDITestQualifier" => [
                "dbType" => "varchar(2)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"EDITestID" => [
                "dbType" => "varchar(12)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"EDIContactName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"EDIContactAddressLine" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"EDIContactAgentPhone" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"EDIContactAgentFax" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"EDIPurchaseOrders" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
			],
			"EDIInvoices" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
			],
			"EDIShippingNotices" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
			],
			"EDIOrderStatus" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
			],
			"EDIPayments" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
			]
		],
		"Additional" => [
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
			"ConvertedFromCustomer" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
			],
			"VendorRegionID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"VendorSourceID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"VendorIndustryID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"Comfirmed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
			],
			"FirstContacted" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
			],
			"LastFollowUp" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
			],
			"NextFollowUp" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
			],
			"ReferedBy" => [
                "dbType" => "varchar(15)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"ReferedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
			],
			"ReferalURL" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
			],
			"Hot" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
			]
		],
        "Vendor Transactions" => [
            "VendorID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text"
            ]
        ],
        "Vendor Transactions History" => [
            "VendorID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text"
            ]
        ]
    ];
    public $columnNames = [
        "VendorID" => "Vendor ID",
        "VendorTypeID" => "Vendor Type ID",
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
        "VendorFax" => "Vendor Fax",
        "VendorWebPage" => "Vendor Web Page",
        "VendorPasswordOld" => "Vendor Password Old",
        "VendorPasswordDate" => "Vendor Password Date",
        "VendorPasswordExpires" => "Vendor Password Expires",
        "VendorPasswordExpiresDate" => "Vendor Password Expires Date",
        "Attention" => "Attention",
        "AccountNumber" => "Account Number",
        "ContactID" => "Contact ID",
        "RemittToName" => "Remitt To Name",
        "RemittToAddress1" => "Remitt To Address 1",
        "RemittToAddress2" => "Remitt To Address 2",
        "RemittToAddress3" => "Remitt To Address 3",
        "RemittToCity" => "Remitt To City",
        "RemittToState" => "Remitt To State",
        "RemittToZip" => "Remitt To Zip",
        "RemittToCountry" => "Remitt To Country",
        "RemittToPhone" => "Remitt To Phone",
        "RemittToFax" => "Remitt To Fax",
        "RemittToEmail" => "Remitt To Email",
        "RemittToWebsite" => "Remitt To Website",
        "RemittToNotes" => "Remitt To Notes",
        "ShipMethodID" => "ShipMethod ID",
        "WarehouseID" => "Warehouse ID",
        "PriceMatrix" => "Price Matrix",
        "PriceMatrixCurrent" => "Price Matrix Current",
        "CurrencyID" => "Currency ID",
        "TermsID" => "Terms ID",
        "TermsStart" => "Terms Start",
        "GLPurchaseAccount" => "GL Purchase Account",
        "TaxIDNo" => "Tax ID No",
        "VATTaxIDNumber" => "VAT Tax ID Number",
        "VatTaxOtherNumber" => "Vat Tax Other Number",
        "TaxGroupID" => "Tax Group ID",
        "CreditLimit" => "Credit Limit",
        "AvailibleCredit" => "Availible Credit",
        "CreditComments" => "Credit Comments",
        "CreditRating" => "Credit Rating",
        "ApprovalDate" => "Approval Date",
        "CustomerSince" => "Customer Since",
        "FreightPayment" => "Freight Payment",
        "CustomerSpecialInstructions" => "Customer Special Instructions",
        "SpecialTerms" => "Special Terms",
        "Vendor1099" => "Vendor 1099",
        "EDIQualifier" => "EDI Qualifier",
        "EDIID" => "EDI ID",
        "EDITestQualifier" => "EDI Test Qualifier",
        "EDITestID" => "EDI Test ID",
        "EDIContactName" => "EDI Contact Name",
        "EDIContactAddressLine" => "EDI Contact Address Line",
        "EDIContactAgentPhone" => "EDI Contact Agent Phone",
        "EDIContactAgentFax" => "EDI Contact Agent Fax",
        "EDIPurchaseOrders" => "EDI Purchase Orders",
        "EDIInvoices" => "EDI Invoices",
        "EDIShippingNotices" => "EDI Shipping Notices",
        "EDIOrderStatus" => "EDI Order Status",
        "EDIPayments" => "EDI Payments",
        "Approved" => "Approved",
        "ApprovedBy" => "Approved By",
        "ApprovedDate" => "Approved Date",
        "EnteredBy" => "Entered By",
        "ConvertedFromCustomer" => "Converted From Customer",
        "VendorRegionID" => "Vendor Region ID",
        "VendorSourceID" => "Vendor Source ID",
        "VendorIndustryID" => "Vendor Industry ID",
        "Comfirmed" => "Comfirmed",
        "FirstContacted" => "First Contacted",
        "LastFollowUp" => "Last Follow Up",
        "NextFollowUp" => "Next Follow Up",
        "ReferedBy" => "Refered By",
        "ReferedDate" => "Refered Date",
        "ReferalURL" => "Referal URL",
        "Hot" => "Hot",
        "TransactionType" => "Transaction Type",
		"TransactionNumber" => "Transaction Number",
		"TransactionDate" => "Transaction Date",
		"TransactionAmount" => "Transaction Amount",
        "CurrencyID" => "Currency ID",
		"ShipDate" => "Ship Date",
		"TrackingNumber" => "Tracking Number"
    ];
    public $transactionsIdFields = ["CompanyID","DivisionID","DepartmentID","VendorID"];
	public $transactionsFields = [
		"TransactionType" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"TransactionNumber" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"TransactionDate" => [
			"dbType" => "datetime",
			"inputType" => "datetime"
		],
		"TransactionAmount" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
		],
        "CurrencyID" =>	[
            "dbType" => "varchar(3)",
            "inputType" => "dropdown",
        ],
		"ShipDate" => [
			"dbType" => "datetime",
			"inputType" => "datetime"
		],
		"TrackingNumber" => [
			"dbType" => "varchar(50)",
			"inputType" => "text"
		]
	];
    
    //getting rows for grid
    public function getTransactions($VendorID, $type){
        $user = $_SESSION["user"];
        $keyFields = "";
        $fields = [];
        foreach($this->transactionsFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->transactionsIdFields as $key){
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

        $keyFields .= " AND VendorID='" . $VendorID . "'";

        
        $result = $GLOBALS["capsule"]::select("SELECT " . implode(",", $fields) . " from " . ( $type == "history" ? "vendorhistorytransactions " : "vendortransactions " ) . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
}
?>
