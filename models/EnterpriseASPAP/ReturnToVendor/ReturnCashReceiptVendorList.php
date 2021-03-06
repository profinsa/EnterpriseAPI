<?php
/*
  Name of Page: ReturnCashReceiptList model

  Method: Model for gridView It provides data from database and default values, column names and categories

  Date created: 06/16/2017 Nikita Zaharov

  Use: this model used by gridView for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by Grid controller
  used as model by gridView

  Calls:
  MySql Database

  Last Modified: 08/15/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class ReturnCashReceiptVendorList extends gridDataSource{
    public $tableName = "vendorinformation";
    public $dashboardTitle ="Return Cash Receipts - Vendors";
    public $breadCrumbTitle ="Return Cash Receipts - Vendors";
    public $idField ="VendorID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID"];
    public $modes = ["grid", "edit"]; // list of enabled modes
    public $gridFields = [
        "VendorID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "VendorTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "AccountStatus" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "VendorName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "VendorPhone" => [
            "dbType" => "varchar(50)",
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
            ],
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
            ],
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
            ],
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
        ]
    ];
    public $columnNames = [
        "VendorID" => "Vendor ID",
        "VendorTypeID" => "Vendor Type ID",
        "AccountStatus" => "Account Status",
        "VendorName" => "Vendor Name",
        "VendorPhone" => "Vendor Phone",
        "VendorLogin" => "Vendor Login",
        "VendorPassword" => "Vendor Password",
        "VendorAddress1" => "VendorAddress1",
        "VendorAddress2" => "VendorAddress2",
        "VendorAddress3" => "VendorAddress3",
        "VendorCity" => "VendorCity",
        "VendorState" => "VendorState",
        "VendorZip" => "VendorZip",
        "VendorCountry" => "VendorCountry",
        "VendorFax" => "VendorFax",
        "VendorEmail" => "VendorEmail",
        "VendorWebPage" => "VendorWebPage",
        "VendorPasswordOld" => "VendorPasswordOld",
        "VendorPasswordDate" => "VendorPasswordDate",
        "VendorPasswordExpires" => "VendorPasswordExpires",
        "VendorPasswordExpiresDate" => "VendorPasswordExpiresDate",
        "Attention" => "Attention",
        "AccountNumber" => "AccountNumber",
        "ContactID" => "ContactID",
        "RemittToName" => "RemittToName",
        "RemittToAddress1" => "RemittToAddress1",
        "RemittToAddress2" => "RemittToAddress2",
        "RemittToAddress3" => "RemittToAddress3",
        "RemittToCity" => "RemittToCity",
        "RemittToState" => "RemittToState",
        "RemittToZip" => "RemittToZip",
        "RemittToCountry" => "RemittToCountry",
        "RemittToPhone" => "RemittToPhone",
        "RemittToFax" => "RemittToFax",
        "RemittToEmail" => "RemittToEmail",
        "RemittToWebsite" => "RemittToWebsite",
        "RemittToNotes" => "RemittToNotes",
        "ShipMethodID" => "ShipMethodID",
        "WarehouseID" => "WarehouseID",
        "PriceMatrix" => "PriceMatrix",
        "PriceMatrixCurrent" => "PriceMatrixCurrent",
        "CurrencyID" => "CurrencyID",
        "TermsID" => "TermsID",
        "TermsStart" => "TermsStart",
        "GLPurchaseAccount" => "GLPurchaseAccount",
        "TaxIDNo" => "TaxIDNo",
        "VATTaxIDNumber" => "VATTaxIDNumber",
        "VatTaxOtherNumber" => "VatTaxOtherNumber",
        "TaxGroupID" => "TaxGroupID",
        "CreditLimit" => "CreditLimit",
        "AvailibleCredit" => "AvailibleCredit",
        "CreditComments" => "CreditComments",
        "CreditRating" => "CreditRating",
        "ApprovalDate" => "ApprovalDate",
        "CustomerSince" => "CustomerSince",
        "FreightPayment" => "FreightPayment",
        "CustomerSpecialInstructions" => "CustomerSpecialInstructions",
        "SpecialTerms" => "SpecialTerms",
        "Vendor1099" => "Vendor1099",
        "EDIQualifier" => "EDIQualifier",
        "EDIID" => "EDIID",
        "EDITestQualifier" => "EDITestQualifier",
        "EDITestID" => "EDITestID",
        "EDIContactName" => "EDIContactName",
        "EDIContactAddressLine" => "EDIContactAddressLine",
        "EDIContactAgentPhone" => "EDIContactAgentPhone",
        "EDIContactAgentFax" => "EDIContactAgentFax",
        "EDIPurchaseOrders" => "EDIPurchaseOrders",
        "EDIInvoices" => "EDIInvoices",
        "EDIShippingNotices" => "EDIShippingNotices",
        "EDIOrderStatus" => "EDIOrderStatus",
        "EDIPayments" => "EDIPayments",
        "Approved" => "Approved",
        "ApprovedBy" => "ApprovedBy",
        "ApprovedDate" => "ApprovedDate",
        "EnteredBy" => "EnteredBy",
        "ConvertedFromCustomer" => "ConvertedFromCustomer",
        "VendorRegionID" => "VendorRegionID",
        "VendorSourceID" => "VendorSourceID",
        "VendorIndustryID" => "VendorIndustryID",
        "Comfirmed" => "Comfirmed",
        "FirstContacted" => "FirstContacted",
        "LastFollowUp" => "LastFollowUp",
        "NextFollowUp" => "NextFollowUp",
        "ReferedBy" => "ReferedBy",
        "ReferedDate" => "ReferedDate",
        "ReferalURL" => "ReferalURL",
        "Hot" => "Hot"
    ];

    //getting rows for grid
    public function getPage($customer){
        $user = Session::get("user");
        $CompanyID = "'{$user["CompanyID"]}'";
        $DivisionID = "'{$user["DivisionID"]}'";
        $DepartmentID = "'{$user["DepartmentID"]}'";
        $query = <<<EOF
			SELECT     CompanyID AS CompanyID, DivisionID AS DivisionID, DepartmentID AS DepartmentID, VendorID AS VendorID, AccountStatus AS AccountStatus,
			VendorName AS VendorName, VendorPhone AS VendorPhone, VendorLogin AS VendorLogin, VendorPassword AS VendorPassword,
			VendorTypeID AS VendorTypeID
			FROM         VendorInformation AS ReturnCashReceiptVendor
			WHERE    ((CompanyID = $CompanyID) AND (DivisionID = $DivisionID) AND (DepartmentID = $DepartmentID) AND IFNULL(ConvertedFromCustomer, 0) = 0 AND
			EXISTS
			(SELECT     ReceiptID
			FROM          ReceiptsHeader
			WHERE      ReceiptsHeader.CompanyID = $CompanyID AND ReceiptsHeader.DivisionID = $DivisionID AND
			ReceiptsHeader.DepartmentID = $DepartmentID AND ReturnCashReceiptVendor.VendorID = ReceiptsHeader.CustomerID AND
			ReceiptsHeader.Posted = 1 AND (ReceiptsHeader.CreditAmount IS NULL OR
			ReceiptsHeader.CreditAmount <> 0) AND ReceiptsHeader.ReceiptClassID = 'Vendor') OR
			(CompanyID = $CompanyID) AND (DivisionID = $DivisionID) AND (DepartmentID = $DepartmentID) AND IFNULL(ConvertedFromCustomer, 0) = 0 AND
			EXISTS
			(SELECT     InvoiceNumber
			FROM          InvoiceHeader
			WHERE      InvoiceHeader.CompanyID = $CompanyID AND InvoiceHeader.DivisionID = $DivisionID AND
			InvoiceHeader.DepartmentID = $DepartmentID AND ReturnCashReceiptVendor.VendorID = InvoiceHeader.CustomerID AND
			InvoiceHeader.TransactionTypeID = 'Credit Memo' AND InvoiceHeader.Posted = 1 AND ABS(IFNULL(InvoiceHeader.Total, 0)
			- IFNULL(InvoiceHeader.AmountPaid, 0)) > 0.005))
EOF;
        $result = DB::select($query, array());
        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
}
?>

