<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customerinformation";
protected $gridFields =["CustomerID","CustomerTypeID","CustomerName","CustomerLogin","CustomerPassword"];
public $dashboardTitle ="Customer Information";
public $breadCrumbTitle ="Customer Information";
public $idField ="CustomerID";
public $editCategories = [
"Main" => [

"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AccountStatus" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerSex" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerBornDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerNationality" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerAddress3" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerState" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerWebPage" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerLogin" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerPassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerPasswordOld" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerPasswordDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerPasswordExpires" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerPasswordExpiresDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerFirstName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerLastName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerSalutation" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerSpeciality" => [
"inputType" => "text",
"defaultValue" => ""
],
"Attention" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxIDNo" => [
"inputType" => "text",
"defaultValue" => ""
],
"VATTaxIDNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"VatTaxOtherNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLSalesAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"TermsID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TermsStart" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxGroupID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PriceMatrix" => [
"inputType" => "text",
"defaultValue" => ""
],
"PriceMatrixCurrent" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditRating" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditLimit" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditComments" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentDay" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovalDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerSince" => [
"inputType" => "text",
"defaultValue" => ""
],
"SendCreditMemos" => [
"inputType" => "text",
"defaultValue" => ""
],
"SendDebitMemos" => [
"inputType" => "text",
"defaultValue" => ""
],
"Statements" => [
"inputType" => "text",
"defaultValue" => ""
],
"StatementCycleCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerSpecialInstructions" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerShipToId" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerShipForId" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipMethodID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseID" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingInfo1" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingInfo2" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingInfo3" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingInfoCurrent" => [
"inputType" => "text",
"defaultValue" => ""
],
"FreightPayment" => [
"inputType" => "text",
"defaultValue" => ""
],
"PickTicketsNeeded" => [
"inputType" => "text",
"defaultValue" => ""
],
"PackingListNeeded" => [
"inputType" => "text",
"defaultValue" => ""
],
"SpecialLabelsNeeded" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerItemCodes" => [
"inputType" => "text",
"defaultValue" => ""
],
"ConfirmBeforeShipping" => [
"inputType" => "text",
"defaultValue" => ""
],
"Backorders" => [
"inputType" => "text",
"defaultValue" => ""
],
"UseStoreNumbers" => [
"inputType" => "text",
"defaultValue" => ""
],
"UseDepartmentNumbers" => [
"inputType" => "text",
"defaultValue" => ""
],
"SpecialShippingInstructions" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApplyRebate" => [
"inputType" => "text",
"defaultValue" => ""
],
"RebateAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"RebateGLAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"RebateAmountNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApplyNewStore" => [
"inputType" => "text",
"defaultValue" => ""
],
"NewStoreDiscount" => [
"inputType" => "text",
"defaultValue" => ""
],
"NewStoreGLAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"NewStoreDiscountNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApplyWarehouse" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseAllowance" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseGLAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseAllowanceNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApplyAdvertising" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdvertisingDiscount" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdvertisingGLAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdvertisingDiscountNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApplyManualAdvert" => [
"inputType" => "text",
"defaultValue" => ""
],
"ManualAdvertising" => [
"inputType" => "text",
"defaultValue" => ""
],
"ManualAdvertisingGLAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"ManualAdvertisingNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApplyTrade" => [
"inputType" => "text",
"defaultValue" => ""
],
"TradeDiscount" => [
"inputType" => "text",
"defaultValue" => ""
],
"TradeDiscountGLAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"TradeDiscountNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"SpecialTerms" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIQualifier" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDITestQualifier" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDITestID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIContactName" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIContactAgentFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIContactAgentPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIContactAddressLine" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIPurchaseOrders" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIInvoices" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIPayments" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIOrderStatus" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIShippingNotices" => [
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"EnteredBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ConvertedFromVendor" => [
"inputType" => "text",
"defaultValue" => ""
],
"ConvertedFromLead" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerRegionID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerSourceID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerIndustryID" => [
"inputType" => "text",
"defaultValue" => ""
],
"Confirmed" => [
"inputType" => "text",
"defaultValue" => ""
],
"FirstContacted" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastFollowUp" => [
"inputType" => "text",
"defaultValue" => ""
],
"NextFollowUp" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferedByExistingCustomer" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferedDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferalURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"Hot" => [
"inputType" => "text",
"defaultValue" => ""
],
"PrimaryInterest" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"CustomerTypeID" => "Customer Type ID",
"CustomerName" => "Customer Name",
"CustomerLogin" => "Customer Login",
"CustomerPassword" => "Customer Password",
"CustomerFirstName" => "Customer First Name",
"CustomerLastName" => "Customer Last Name",
"CustomerSalutation" => "Customer Salutation",
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
"Attention" => "Attention",
"TaxIDNo" => "Tax ID Number",
"TermsStart" => "Terms Start",
"PriceMatrix" => "Price Matrix",
"PriceMatrixCurrent" => "Price Matrix Current",
"CreditRating" => "Credit Rating",
"CreditLimit" => "Credit Limit",
"CreditComments" => "Credit Comments",
"PaymentDay" => "Payment Day",
"ApprovalDate" => "Approval Date",
"CustomerSince" => "Customer Since",
"StatementCycleCode" => "Statement Cycle Code",
"CustomerSpecialInstructions" => "Customer Special Instructions",
"RoutingInfo1" => "Routing Info 1",
"RoutingInfo2" => "Routing Info 2",
"RoutingInfo3" => "Routing Info 3",
"RoutingInfoCurrent" => "Routing Info Current",
"FreightPayment" => "Freight Payment",
"SpecialShippingInstructions" => "Special Shipping Instructions",
"RoutingNotes" => "Routing Notes",
"RebateAmount" => "Rebate Amount",
"RebateAmountNotes" => "Rebate Amount Notes",
"NewStoreDiscount" => "New Store Discount",
"NewStoreDiscountNotes" => "New Store Discount Notes",
"WarehouseAllowance" => "Warehouse Allowance",
"WarehouseAllowanceNotes" => "Warehouse Allowance Notes",
"AdvertisingDiscount" => "Advertising Discount",
"AdvertisingDiscountNotes" => "Advertising Discount Notes",
"ManualAdvertising" => "Manual Advertising",
"ManualAdvertisingNotes" => "Manual Advertising Notes",
"TradeDiscount" => "Trade Discount",
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
"ShipToID" => "Ship To ID",
"ShipToName" => "Name",
"ShipToAddress1" => "Address 1",
"ShipToAddress2" => "Address 2",
"ShipToAddress3" => "Address 3",
"ShipToCity" => "City",
"ShipToState" => "State",
"ShipToZip" => "Zip",
"ShipForID" => "Ship For ID",
"ShipForName" => "Name",
"ShipForAddress1" => "Address 1",
"ShipForAddress2" => "Address 2",
"ShipForAddress3" => "Address 3",
"ShipForCity" => "City",
"ShipForState" => "State",
"ShipForZip" => "Zip",
"BookedOrders" => "Booked Orders",
"AvailibleCredit" => "Available Credit",
"AverageDaytoPay" => "Average Days",
"LateDays" => "Late Days",
"LastPaymentDate" => "Last Payment Date",
"LastPaymentAmount" => "Last Payment Amount",
"PromptPerc" => "Prompt Perc",
"HighestCredit" => "Highest Credit",
"HighestBalance" => "Highest Balance",
"AdvertisingDollars" => "Advertising Dollars",
"CurrentARBalance" => "Current AR Balance",
"TotalAR" => "Total AR",
"Under30" => "Under 30",
"Over30" => "Over 30",
"Over60" => "Over 60",
"Over90" => "Over 90",
"Over120" => "Over 120",
"Over150" => "Over 150",
"Over180" => "Over 180",
"LastSalesDate" => "Last Sales Date",
"SalesYTD" => "Sales YTD",
"SalesLastYear" => "Sales Last Year",
"SalesLifetime" => "Sales Lifetime",
"PaymentsYTD" => "Payments YTD",
"PaymentsLastYear" => "Payments Last Year",
"PaymentsLifetime" => "Payments Lifetime",
"WriteOffsYTD" => "Write Offs YTD",
"WriteOffsLastYear" => "Write Offs Last Year",
"WriteOffsLifetime" => "Write Offs Lifetime",
"InvoicesYTD" => "Invoices YTD",
"InvoicesLastYear" => "Invoices Las tYear",
"InvoicesLifetime" => "Invoices Lifetime",
"CreditMemos" => "Credit Memos",
"LastCreditMemoDate" => "Last Credit Memo Date",
"CreditMemosYTD" => "Credit Memos YTD",
"CreditMemosLastYear" => "Credit Memos Last Year",
"CreditMemosLifetime" => "Credit Memos Lifetime",
"RMAs" => "RMAs",
"LastRMADate" => "Last RMA Date",
"RMAsYTD" => "RMAs YTD",
"RMAsLastYear" => "RMAs Last Year",
"RMAsLifetime" => "RMAs Lifetime",
"ReferenceID" => "Reference ID",
"ReferenceName" => "Name",
"ReferenceDate" => "Date",
"ReferenceSoldSince" => "Sold Since",
"ReferenceLastSale" => "Last Sale",
"ReferenceHighCredit" => "High Credit",
"ReferenceCurrentBalance" => "Current Balance",
"ReferencePastDue" => "Past Due",
"ReferenceLateDays" => "Late Days",
"CommentLineID" => "Line ID",
"CommentDate" => "Date",
"CommentType" => "Type",
"Comment" => "Comment",
"TransactionType" => "Transaction Type",
"TransactionNumber" => "Transaction Number",
"TransactionDate" => "Transaction Date",
"TransactionAmount" => "Transaction Amount",
"CurrencyID" => "Currency ID",
"ShipDate" => "Ship Date",
"TrackingNumber" => "Tracking Number",
"AccountStatus" => "AccountStatus",
"CustomerSex" => "CustomerSex",
"CustomerBornDate" => "CustomerBornDate",
"CustomerNationality" => "CustomerNationality",
"CustomerPasswordOld" => "CustomerPasswordOld",
"CustomerPasswordDate" => "CustomerPasswordDate",
"CustomerPasswordExpires" => "CustomerPasswordExpires",
"CustomerPasswordExpiresDate" => "CustomerPasswordExpiresDate",
"CustomerSpeciality" => "CustomerSpeciality",
"VATTaxIDNumber" => "VATTaxIDNumber",
"VatTaxOtherNumber" => "VatTaxOtherNumber",
"GLSalesAccount" => "GLSalesAccount",
"TermsID" => "TermsID",
"EmployeeID" => "EmployeeID",
"TaxGroupID" => "TaxGroupID",
"SendCreditMemos" => "SendCreditMemos",
"SendDebitMemos" => "SendDebitMemos",
"Statements" => "Statements",
"CustomerShipToId" => "CustomerShipToId",
"CustomerShipForId" => "CustomerShipForId",
"ShipMethodID" => "ShipMethodID",
"WarehouseID" => "WarehouseID",
"PickTicketsNeeded" => "PickTicketsNeeded",
"PackingListNeeded" => "PackingListNeeded",
"SpecialLabelsNeeded" => "SpecialLabelsNeeded",
"CustomerItemCodes" => "CustomerItemCodes",
"ConfirmBeforeShipping" => "ConfirmBeforeShipping",
"Backorders" => "Backorders",
"UseStoreNumbers" => "UseStoreNumbers",
"UseDepartmentNumbers" => "UseDepartmentNumbers",
"ApplyRebate" => "ApplyRebate",
"RebateGLAccount" => "RebateGLAccount",
"ApplyNewStore" => "ApplyNewStore",
"NewStoreGLAccount" => "NewStoreGLAccount",
"ApplyWarehouse" => "ApplyWarehouse",
"WarehouseGLAccount" => "WarehouseGLAccount",
"ApplyAdvertising" => "ApplyAdvertising",
"AdvertisingGLAccount" => "AdvertisingGLAccount",
"ApplyManualAdvert" => "ApplyManualAdvert",
"ManualAdvertisingGLAccount" => "ManualAdvertisingGLAccount",
"ApplyTrade" => "ApplyTrade",
"TradeDiscountGLAccount" => "TradeDiscountGLAccount",
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
"PrimaryInterest" => "PrimaryInterest"];
}?>
