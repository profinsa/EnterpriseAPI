<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "leadinformation";
protected $gridFields =["LeadID","LeadLastName","LeadFirstName","LeadEmail","LeadLogin","LeadPassword","Hot","Confirmed"];
public $dashboardTitle ="Lead Information";
public $breadCrumbTitle ="Lead Information";
public $idField ="LeadID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","LeadID"];
public $editCategories = [
"Main" => [

"LeadID" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadCompany" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadLastName" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadFirstName" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadSalutation" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadAddress3" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadState" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadWebPage" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadLogin" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadPassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadPasswordOld" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadPasswordDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"LeadPasswordExpires" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadPasswordExpiresDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadSecurityGroup" => [
"inputType" => "text",
"defaultValue" => ""
],
"Attention" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadRegionID" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadSourceID" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadIndustryID" => [
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
"LastVisit" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"IPAddress" => [
"inputType" => "text",
"defaultValue" => ""
],
"NumberOfVisits" => [
"inputType" => "text",
"defaultValue" => ""
],
"PrimaryInterest" => [
"inputType" => "text",
"defaultValue" => ""
],
"Confirmed" => [
"inputType" => "text",
"defaultValue" => ""
],
"Validated" => [
"inputType" => "text",
"defaultValue" => ""
],
"OptInEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"Newsletter" => [
"inputType" => "text",
"defaultValue" => ""
],
"OptInNewsletter" => [
"inputType" => "text",
"defaultValue" => ""
],
"MessageBoard" => [
"inputType" => "text",
"defaultValue" => ""
],
"Portal" => [
"inputType" => "text",
"defaultValue" => ""
],
"Hot" => [
"inputType" => "text",
"defaultValue" => ""
],
"ConvertedToCustomer" => [
"inputType" => "text",
"defaultValue" => ""
],
"ConvertedToCustomerBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ConvertedToCustomerDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"LeadMemo1" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo2" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo3" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo4" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo5" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo6" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo7" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo8" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo9" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"LeadID" => "Lead ID",
"LeadLastName" => "Last Name",
"LeadFirstName" => "First Name",
"LeadEmail" => "Email",
"LeadLogin" => "Login",
"LeadPassword" => "Password",
"Hot" => "Hot",
"Confirmed" => "Confirmed",
"LeadCompany" => "LeadCompany",
"LeadSalutation" => "LeadSalutation",
"LeadAddress1" => "LeadAddress1",
"LeadAddress2" => "LeadAddress2",
"LeadAddress3" => "LeadAddress3",
"LeadCity" => "LeadCity",
"LeadState" => "LeadState",
"LeadZip" => "LeadZip",
"LeadCountry" => "LeadCountry",
"LeadWebPage" => "LeadWebPage",
"LeadPhone" => "LeadPhone",
"LeadFax" => "LeadFax",
"LeadPasswordOld" => "LeadPasswordOld",
"LeadPasswordDate" => "LeadPasswordDate",
"LeadPasswordExpires" => "LeadPasswordExpires",
"LeadPasswordExpiresDate" => "LeadPasswordExpiresDate",
"LeadSecurityGroup" => "LeadSecurityGroup",
"Attention" => "Attention",
"EmployeeID" => "EmployeeID",
"CurrencyID" => "CurrencyID",
"LeadTypeID" => "LeadTypeID",
"LeadRegionID" => "LeadRegionID",
"LeadSourceID" => "LeadSourceID",
"LeadIndustryID" => "LeadIndustryID",
"FirstContacted" => "FirstContacted",
"LastFollowUp" => "LastFollowUp",
"NextFollowUp" => "NextFollowUp",
"ReferedByExistingCustomer" => "ReferedByExistingCustomer",
"ReferedBy" => "ReferedBy",
"ReferedDate" => "ReferedDate",
"ReferalURL" => "ReferalURL",
"LastVisit" => "LastVisit",
"IPAddress" => "IPAddress",
"NumberOfVisits" => "NumberOfVisits",
"PrimaryInterest" => "PrimaryInterest",
"Validated" => "Validated",
"OptInEmail" => "OptInEmail",
"Newsletter" => "Newsletter",
"OptInNewsletter" => "OptInNewsletter",
"MessageBoard" => "MessageBoard",
"Portal" => "Portal",
"ConvertedToCustomer" => "ConvertedToCustomer",
"ConvertedToCustomerBy" => "ConvertedToCustomerBy",
"ConvertedToCustomerDate" => "ConvertedToCustomerDate",
"LeadMemo1" => "LeadMemo1",
"LeadMemo2" => "LeadMemo2",
"LeadMemo3" => "LeadMemo3",
"LeadMemo4" => "LeadMemo4",
"LeadMemo5" => "LeadMemo5",
"LeadMemo6" => "LeadMemo6",
"LeadMemo7" => "LeadMemo7",
"LeadMemo8" => "LeadMemo8",
"LeadMemo9" => "LeadMemo9"];
}?>
