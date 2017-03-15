<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendorinformation";
public $gridFields =["VendorID","VendorTypeID","VendorName","VendorEmail","VendorLogin","VendorPassword"];
public $dashboardTitle ="Vendors Information";
public $breadCrumbTitle ="Vendors Information";
public $idField ="VendorID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID"];
public $editCategories = [
"Main" => [

"VendorID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AccountStatus" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorName" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorAddress3" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorState" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorWebPage" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorLogin" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorPassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorPasswordOld" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorPasswordDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"VendorPasswordExpires" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorPasswordExpiresDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"Attention" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AccountNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactID" => [
"inputType" => "text",
"defaultValue" => ""
],
"RemittToName" => [
"inputType" => "text",
"defaultValue" => ""
],
"RemittToAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"RemittToAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"RemittToAddress3" => [
"inputType" => "text",
"defaultValue" => ""
],
"RemittToCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"RemittToState" => [
"inputType" => "text",
"defaultValue" => ""
],
"RemittToZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"RemittToCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"RemittToPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"RemittToFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"RemittToEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"RemittToWebsite" => [
"inputType" => "text",
"defaultValue" => ""
],
"RemittToNotes" => [
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
"PriceMatrix" => [
"inputType" => "text",
"defaultValue" => ""
],
"PriceMatrixCurrent" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"CurrencyID" => [
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
"GLPurchaseAccount" => [
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
"TaxGroupID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditLimit" => [
"inputType" => "text",
"defaultValue" => ""
],
"AvailibleCredit" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditComments" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditRating" => [
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
"FreightPayment" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerSpecialInstructions" => [
"inputType" => "text",
"defaultValue" => ""
],
"SpecialTerms" => [
"inputType" => "text",
"defaultValue" => ""
],
"Vendor1099" => [
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
"EDIContactAddressLine" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIContactAgentPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIContactAgentFax" => [
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
"EDIShippingNotices" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIOrderStatus" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIPayments" => [
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
"ConvertedFromCustomer" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorRegionID" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorSourceID" => [
"inputType" => "text",
"defaultValue" => ""
],
"VendorIndustryID" => [
"inputType" => "text",
"defaultValue" => ""
],
"Comfirmed" => [
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
]
]];
public $columnNames = [

"VendorID" => "Vendor ID",
"VendorTypeID" => "Vendor Type ID",
"VendorName" => "Vendor Name",
"VendorEmail" => "Vendor Email",
"VendorLogin" => "Vendor Login",
"VendorPassword" => "Vendor Password",
"AccountStatus" => "AccountStatus",
"VendorAddress1" => "VendorAddress1",
"VendorAddress2" => "VendorAddress2",
"VendorAddress3" => "VendorAddress3",
"VendorCity" => "VendorCity",
"VendorState" => "VendorState",
"VendorZip" => "VendorZip",
"VendorCountry" => "VendorCountry",
"VendorPhone" => "VendorPhone",
"VendorFax" => "VendorFax",
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
"Hot" => "Hot"];
}?>
