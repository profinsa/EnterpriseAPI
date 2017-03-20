<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
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
