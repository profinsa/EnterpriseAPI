<?php

/*
Name of Page: CustomerInformationList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Customers\CustomerInformationList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/CustomerInformationList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Customers\CustomerInformationList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Customers\CustomerInformationList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
	protected $tableName = "customerinformation";
	public $dashboardTitle ="Customer Information";
	public $breadCrumbTitle ="Customer Information";
	public $idField ="CustomerID";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID"];
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
			]
		],
		"Info" => [
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
			]
		],
		"Shipping" => [
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
			]
		],
		"Allowance" => [
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
			]
		],
		"Approval" => [
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
			]
		],
		"Additional" => [
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
		"CustomerLogin" => "Customer Login",
		"CustomerPassword" => "Customer Password",
		"AccountStatus" => "Account Status",
		"CustomerSex" => "Customer Sex",
		"CustomerBornDate" => "Customer Born Date",
		"CustomerNationality" => "Customer Nationality",
		"CustomerAddress1" => "Customer Address 1",
		"CustomerAddress2" => "Customer Address 2",
		"CustomerAddress3" => "Customer Address 3",
		"CustomerCity" => "Customer City",
		"CustomerState" => "Customer State",
		"CustomerZip" => "Customer Zip",
		"CustomerCountry" => "Customer Country",
		"CustomerPhone" => "Customer Phone",
		"CustomerFax" => "Customer Fax",
		"CustomerEmail" => "Customer Email",
		"CustomerWebPage" => "Customer Web Page",
		"CustomerPasswordOld" => "Customer Password Old",
		"CustomerPasswordDate" => "Customer Password Date",
		"CustomerPasswordExpires" => "Customer Password Expires",
		"CustomerPasswordExpiresDate" => "Customer Password Expires Date",
		"CustomerFirstName" => "Customer First Name",
		"CustomerLastName" => "Customer Last Name",
		"CustomerSalutation" => "Customer Salutation",
		"CustomerSpeciality" => "Customer Speciality",
		"Attention" => "Attention",
		"TaxIDNo" => "Tax ID No",
		"VATTaxIDNumber" => "VAT Tax ID Number",
		"VatTaxOtherNumber" => "Vat Tax Other Number",
		"CurrencyID" => "Currency ID",
		"GLSalesAccount" => "GL Sales Account",
		"TermsID" => "Terms ID",
		"TermsStart" => "Terms Start",
		"EmployeeID" => "Employee ID",
		"TaxGroupID" => "Tax Group ID",
		"PriceMatrix" => "Price Matrix",
		"PriceMatrixCurrent" => "Price Matrix Current",
		"CreditRating" => "Credit Rating",
		"CreditLimit" => "Credit Limit",
		"CreditComments" => "Credit Comments",
		"PaymentDay" => "Payment Day",
		"ApprovalDate" => "Approval Date",
		"CustomerSince" => "Customer Since",
		"SendCreditMemos" => "Send Credit Memos",
		"SendDebitMemos" => "Send Debit Memos",
		"Statements" => "Statements",
		"StatementCycleCode" => "Statement Cycle Code",
		"CustomerSpecialInstructions" => "Customer Special Instructions",
		"CustomerShipToId" => "Customer Ship To Id",
		"CustomerShipForId" => "Customer Ship For Id",
		"ShipMethodID" => "Ship Method ID",
		"WarehouseID" => "Warehouse ID",
		"RoutingInfo1" => "Routing Info 1",
		"RoutingInfo2" => "Routing Info 2",
		"RoutingInfo3" => "Routing Info 3",
		"RoutingInfoCurrent" => "Routing Info Current",
		"FreightPayment" => "Freight Payment",
		"PickTicketsNeeded" => "Pick Tickets Needed",
		"PackingListNeeded" => "Packing List Needed",
		"SpecialLabelsNeeded" => "Special Labels Needed",
		"CustomerItemCodes" => "Customer Item Codes",
		"ConfirmBeforeShipping" => "Confirm Before Shipping",
		"Backorders" => "Backorders",
		"UseStoreNumbers" => "Use Store Numbers",
		"UseDepartmentNumbers" => "Use Department Numbers",
		"SpecialShippingInstructions" => "Special Shipping Instructions",
		"RoutingNotes" => "Routing Notes",
		"ApplyRebate" => "Apply Rebate",
		"RebateAmount" => "Rebate Amount",
		"RebateGLAccount" => "Rebate GL Account",
		"RebateAmountNotes" => "Rebate Amount Notes",
		"ApplyNewStore" => "Apply New Store",
		"NewStoreDiscount" => "New Store Discount",
		"NewStoreGLAccount" => "NewStore GL Account",
		"NewStoreDiscountNotes" => "New Store Discount Notes",
		"ApplyWarehouse" => "Apply Warehouse",
		"WarehouseAllowance" => "Warehouse Allowance",
		"WarehouseGLAccount" => "Warehouse GL Account",
		"WarehouseAllowanceNotes" => "Warehouse Allowance Notes",
		"ApplyAdvertising" => "Apply Advertising",
		"AdvertisingDiscount" => "Advertising Discount",
		"AdvertisingGLAccount" => "Advertising GL Account",
		"AdvertisingDiscountNotes" => "Advertising Discount Notes",
		"ApplyManualAdvert" => "Apply Manual Advert",
		"ManualAdvertising" => "Manual Advertising",
		"ManualAdvertisingGLAccount" => "Manual Advertising GL Account",
		"ManualAdvertisingNotes" => "Manual Advertising Notes",
		"ApplyTrade" => "Apply Trade",
		"TradeDiscount" => "Trade Discount",
		"TradeDiscountGLAccount" => "Trade Discount GL Account",
		"TradeDiscountNotes" => "Trade Discount Notes",
		"SpecialTerms" => "Special Terms",
		"EDIQualifier" => "EDI Qualifier",
		"EDIID" => "EDI ID",
		"EDITestQualifier" => "EDI Test Qualifier",
		"EDITestID" => "EDI Test ID",
		"EDIContactName" => "EDI Contact Name",
		"EDIContactAgentFax" => "EDI Contact Agent Fax",
		"EDIContactAgentPhone" => "EDI Contact Agent Phone",
		"EDIContactAddressLine" => "EDI Contact Address Line",
		"EDIPurchaseOrders" => "EDI Purchase Orders",
		"EDIInvoices" => "EDI Invoices",
		"EDIPayments" => "EDI Payments",
		"EDIOrderStatus" => "EDI Order Status",
		"EDIShippingNotices" => "EDI Shipping Notices",
		"Approved" => "Approved",
		"ApprovedBy" => "Approved By",
		"ApprovedDate" => "Approved Date",
		"EnteredBy" => "Entered By",
		"ConvertedFromVendor" => "Converted From Vendor",
		"ConvertedFromLead" => "Converted From Lead",
		"CustomerRegionID" => "Customer Region ID",
		"CustomerSourceID" => "Customer Source ID",
		"CustomerIndustryID" => "Customer Industry ID",
		"Confirmed" => "Confirmed",
		"FirstContacted" => "First Contacted",
		"LastFollowUp" => "Last FollowUp",
		"NextFollowUp" => "Next Follow Up",
		"ReferedByExistingCustomer" => "Refered By Existing Customer",
		"ReferedBy" => "Refered By",
		"ReferedDate" => "Refered Date",
		"ReferalURL" => "Referal URL",
		"Hot" => "Hot",
		"PrimaryInterest" => "Primary Interest"
	];
}
?>
