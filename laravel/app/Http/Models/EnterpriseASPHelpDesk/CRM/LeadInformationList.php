<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "leadinformation";
public $dashboardTitle ="Lead Information";
public $breadCrumbTitle ="Lead Information";
public $idField ="LeadID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","LeadID"];
public $gridFields = [

"LeadID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"LeadLastName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"LeadFirstName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"LeadEmail" => [
    "dbType" => "varchar(60)",
    "inputType" => "text"
],
"LeadLogin" => [
    "dbType" => "varchar(60)",
    "inputType" => "text"
],
"LeadPassword" => [
    "dbType" => "varchar(20)",
    "inputType" => "text"
],
"Hot" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
],
"Confirmed" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"LeadID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadCompany" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadLastName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadFirstName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadSalutation" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadAddress3" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadZip" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadCountry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadEmail" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadWebPage" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadPhone" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadFax" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadLogin" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadPassword" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadPasswordOld" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadPasswordDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"LeadPasswordExpires" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"LeadPasswordExpiresDate" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadSecurityGroup" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
],
"Attention" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadRegionID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadSourceID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadIndustryID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
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
"LastVisit" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"IPAddress" => [
"dbType" => "varchar(11)",
"inputType" => "text",
"defaultValue" => ""
],
"NumberOfVisits" => [
"dbType" => "bigint(20)",
"inputType" => "text",
"defaultValue" => ""
],
"PrimaryInterest" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Confirmed" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Validated" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"OptInEmail" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Newsletter" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"OptInNewsletter" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"MessageBoard" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Portal" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Hot" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ConvertedToCustomer" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ConvertedToCustomerBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ConvertedToCustomerDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"LeadMemo1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo3" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo4" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo5" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo6" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo7" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo8" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadMemo9" => [
"dbType" => "varchar(50)",
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
