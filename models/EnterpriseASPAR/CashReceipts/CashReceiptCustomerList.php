<?php
/*
  Name of Page: CashReceiptCustomerList model

  Method: Model for gridView It provides data from database and default values, column names and categories

  Date created: 05/05/2017 Nikita Zaharov

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
class gridData extends gridDataSource{
    public $tableName = "customerinformation";
    public $dashboardTitle ="Cash Receipts - Customers";
    public $breadCrumbTitle ="Cash Receipts - Customers";
    public $idField ="CustomerID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID"];
    public $modes = ["grid"]; // list of enabled modes
    public $gridFields = [
        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "CustomerTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "CustomerName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "CustomerPhone" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "CustomerLogin" => [
            "dbType" => "varchar(60)",
            "inputType" => "text"
        ],
        "CustomerPassword" => [
            "dbType" => "varchar(20)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
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
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLSalesAccount" => [
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
            "EmployeeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TaxGroupID" => [
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
            "CreditRating" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CreditLimit" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CreditComments" => [
                "dbType" => "varchar(250)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PaymentDay" => [
                "dbType" => "varchar(10)",
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
            "SendCreditMemos" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SendDebitMemos" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Statements" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "StatementCycleCode" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerSpecialInstructions" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerShipToId" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerShipForId" => [
                "dbType" => "varchar(36)",
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
            "RoutingInfo1" => [
                "dbType" => "varchar(100)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RoutingInfo2" => [
                "dbType" => "varchar(100)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RoutingInfo3" => [
                "dbType" => "varchar(100)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RoutingInfoCurrent" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "FreightPayment" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PickTicketsNeeded" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "PackingListNeeded" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SpecialLabelsNeeded" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "CustomerItemCodes" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ConfirmBeforeShipping" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Backorders" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "UseStoreNumbers" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "UseDepartmentNumbers" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "SpecialShippingInstructions" => [
                "dbType" => "varchar(250)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RoutingNotes" => [
                "dbType" => "varchar(200)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ApplyRebate" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "RebateAmount" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RebateGLAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RebateAmountNotes" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ApplyNewStore" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "NewStoreDiscount" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NewStoreGLAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NewStoreDiscountNotes" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ApplyWarehouse" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "WarehouseAllowance" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WarehouseGLAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "WarehouseAllowanceNotes" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ApplyAdvertising" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "AdvertisingDiscount" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AdvertisingGLAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AdvertisingDiscountNotes" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ApplyManualAdvert" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ManualAdvertising" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ManualAdvertisingGLAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ManualAdvertisingNotes" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ApplyTrade" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "TradeDiscount" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TradeDiscountGLAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TradeDiscountNotes" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SpecialTerms" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
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
            "EDIContactAgentFax" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EDIContactAgentPhone" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EDIContactAddressLine" => [
                "dbType" => "varchar(50)",
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
            "EDIPayments" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIOrderStatus" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "EDIShippingNotices" => [
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
            "ConvertedFromVendor" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ConvertedFromLead" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "CustomerRegionID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerSourceID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerIndustryID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Confirmed" => [
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
            "ReferedByExistingCustomer" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
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
            ],
            "PrimaryInterest" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "CustomerID" => "Customer ID",
        "CustomerTypeID" => "Customer Type ID",
        "CustomerName" => "Customer Name",
        "CustomerPhone" => "Customer Phone",
        "CustomerLogin" => "Customer Login",
        "CustomerPassword" => "Customer Password",
        "AccountStatus" => "AccountStatus",
        "CustomerSex" => "CustomerSex",
        "CustomerBornDate" => "CustomerBornDate",
        "CustomerNationality" => "CustomerNationality",
        "CustomerAddress1" => "CustomerAddress1",
        "CustomerAddress2" => "CustomerAddress2",
        "CustomerAddress3" => "CustomerAddress3",
        "CustomerCity" => "CustomerCity",
        "CustomerState" => "CustomerState",
        "CustomerZip" => "CustomerZip",
        "CustomerCountry" => "CustomerCountry",
        "CustomerFax" => "CustomerFax",
        "CustomerEmail" => "CustomerEmail",
        "CustomerWebPage" => "CustomerWebPage",
        "CustomerPasswordOld" => "CustomerPasswordOld",
        "CustomerPasswordDate" => "CustomerPasswordDate",
        "CustomerPasswordExpires" => "CustomerPasswordExpires",
        "CustomerPasswordExpiresDate" => "CustomerPasswordExpiresDate",
        "CustomerFirstName" => "CustomerFirstName",
        "CustomerLastName" => "CustomerLastName",
        "CustomerSalutation" => "CustomerSalutation",
        "CustomerSpeciality" => "CustomerSpeciality",
        "Attention" => "Attention",
        "TaxIDNo" => "TaxIDNo",
        "VATTaxIDNumber" => "VATTaxIDNumber",
        "VatTaxOtherNumber" => "VatTaxOtherNumber",
        "CurrencyID" => "CurrencyID",
        "GLSalesAccount" => "GLSalesAccount",
        "TermsID" => "TermsID",
        "TermsStart" => "TermsStart",
        "EmployeeID" => "EmployeeID",
        "TaxGroupID" => "TaxGroupID",
        "PriceMatrix" => "PriceMatrix",
        "PriceMatrixCurrent" => "PriceMatrixCurrent",
        "CreditRating" => "CreditRating",
        "CreditLimit" => "CreditLimit",
        "CreditComments" => "CreditComments",
        "PaymentDay" => "PaymentDay",
        "ApprovalDate" => "ApprovalDate",
        "CustomerSince" => "CustomerSince",
        "SendCreditMemos" => "SendCreditMemos",
        "SendDebitMemos" => "SendDebitMemos",
        "Statements" => "Statements",
        "StatementCycleCode" => "StatementCycleCode",
        "CustomerSpecialInstructions" => "CustomerSpecialInstructions",
        "CustomerShipToId" => "CustomerShipToId",
        "CustomerShipForId" => "CustomerShipForId",
        "ShipMethodID" => "ShipMethodID",
        "WarehouseID" => "WarehouseID",
        "RoutingInfo1" => "RoutingInfo1",
        "RoutingInfo2" => "RoutingInfo2",
        "RoutingInfo3" => "RoutingInfo3",
        "RoutingInfoCurrent" => "RoutingInfoCurrent",
        "FreightPayment" => "FreightPayment",
        "PickTicketsNeeded" => "PickTicketsNeeded",
        "PackingListNeeded" => "PackingListNeeded",
        "SpecialLabelsNeeded" => "SpecialLabelsNeeded",
        "CustomerItemCodes" => "CustomerItemCodes",
        "ConfirmBeforeShipping" => "ConfirmBeforeShipping",
        "Backorders" => "Backorders",
        "UseStoreNumbers" => "UseStoreNumbers",
        "UseDepartmentNumbers" => "UseDepartmentNumbers",
        "SpecialShippingInstructions" => "SpecialShippingInstructions",
        "RoutingNotes" => "RoutingNotes",
        "ApplyRebate" => "ApplyRebate",
        "RebateAmount" => "RebateAmount",
        "RebateGLAccount" => "RebateGLAccount",
        "RebateAmountNotes" => "RebateAmountNotes",
        "ApplyNewStore" => "ApplyNewStore",
        "NewStoreDiscount" => "NewStoreDiscount",
        "NewStoreGLAccount" => "NewStoreGLAccount",
        "NewStoreDiscountNotes" => "NewStoreDiscountNotes",
        "ApplyWarehouse" => "ApplyWarehouse",
        "WarehouseAllowance" => "WarehouseAllowance",
        "WarehouseGLAccount" => "WarehouseGLAccount",
        "WarehouseAllowanceNotes" => "WarehouseAllowanceNotes",
        "ApplyAdvertising" => "ApplyAdvertising",
        "AdvertisingDiscount" => "AdvertisingDiscount",
        "AdvertisingGLAccount" => "AdvertisingGLAccount",
        "AdvertisingDiscountNotes" => "AdvertisingDiscountNotes",
        "ApplyManualAdvert" => "ApplyManualAdvert",
        "ManualAdvertising" => "ManualAdvertising",
        "ManualAdvertisingGLAccount" => "ManualAdvertisingGLAccount",
        "ManualAdvertisingNotes" => "ManualAdvertisingNotes",
        "ApplyTrade" => "ApplyTrade",
        "TradeDiscount" => "TradeDiscount",
        "TradeDiscountGLAccount" => "TradeDiscountGLAccount",
        "TradeDiscountNotes" => "TradeDiscountNotes",
        "SpecialTerms" => "SpecialTerms",
        "EDIQualifier" => "EDIQualifier",
        "EDIID" => "EDIID",
        "EDITestQualifier" => "EDITestQualifier",
        "EDITestID" => "EDITestID",
        "EDIContactName" => "EDIContactName",
        "EDIContactAgentFax" => "EDIContactAgentFax",
        "EDIContactAgentPhone" => "EDIContactAgentPhone",
        "EDIContactAddressLine" => "EDIContactAddressLine",
        "EDIPurchaseOrders" => "EDIPurchaseOrders",
        "EDIInvoices" => "EDIInvoices",
        "EDIPayments" => "EDIPayments",
        "EDIOrderStatus" => "EDIOrderStatus",
        "EDIShippingNotices" => "EDIShippingNotices",
        "Approved" => "Approved",
        "ApprovedBy" => "ApprovedBy",
        "ApprovedDate" => "ApprovedDate",
        "EnteredBy" => "EnteredBy",
        "ConvertedFromVendor" => "ConvertedFromVendor",
        "ConvertedFromLead" => "ConvertedFromLead",
        "CustomerRegionID" => "CustomerRegionID",
        "CustomerSourceID" => "CustomerSourceID",
        "CustomerIndustryID" => "CustomerIndustryID",
        "Confirmed" => "Confirmed",
        "FirstContacted" => "FirstContacted",
        "LastFollowUp" => "LastFollowUp",
        "NextFollowUp" => "NextFollowUp",
        "ReferedByExistingCustomer" => "ReferedByExistingCustomer",
        "ReferedBy" => "ReferedBy",
        "ReferedDate" => "ReferedDate",
        "ReferalURL" => "ReferalURL",
        "Hot" => "Hot",
        "PrimaryInterest" => "PrimaryInterest"
    ];
}
?>
