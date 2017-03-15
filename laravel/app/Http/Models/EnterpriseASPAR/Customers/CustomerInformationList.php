<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customerinformation";
public $gridFields =["CustomerID","CustomerTypeID","CustomerName","CustomerLogin","CustomerPassword"];
public $dashboardTitle ="Customer Information";
public $breadCrumbTitle ="Customer Information";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID"];
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
"inputType" => "datetime",
"defaultValue" => "now"
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
"inputType" => "datetime",
"defaultValue" => "now"
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
"inputType" => "datetime",
"defaultValue" => "now"
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
"inputType" => "datetime",
"defaultValue" => "now"
],
"CustomerSince" => [
"inputType" => "datetime",
"defaultValue" => "now"
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
"inputType" => "datetime",
"defaultValue" => "now"
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
"inputType" => "datetime",
"defaultValue" => "now"
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
"inputType" => "datetime",
"defaultValue" => "now"
],
"LastFollowUp" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"NextFollowUp" => [
"inputType" => "datetime",
"defaultValue" => "now"
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
"inputType" => "datetime",
"defaultValue" => "now"
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
"CustomerPhone" => "CustomerPhone",
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
"PrimaryInterest" => "PrimaryInterest"];
}?>
