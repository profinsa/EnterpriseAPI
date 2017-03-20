<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "leadcontacts";
public $dashboardTitle ="Lead Contacts";
public $breadCrumbTitle ="Lead Contacts";
public $idField ="LeadID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","LeadID","ContactID"];
public $gridFields = [

"LeadID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ContactID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"LeadType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ContactLastName" => [
    "dbType" => "varchar(20)",
    "inputType" => "text"
],
"ContactFirstName" => [
    "dbType" => "varchar(20)",
    "inputType" => "text"
],
"ContactTitle" => [
    "dbType" => "varchar(20)",
    "inputType" => "text"
],
"ContactPhone" => [
    "dbType" => "varchar(30)",
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
"ContactID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactLastName" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactFirstName" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactTitle" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactDepartment" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactSalutation" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactAddress3" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactZip" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactCountry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactPhone" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactPhone2" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactPhone3" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactFax" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactCellular" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactPager" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactEmail" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactWebPage" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactLogin" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactPassword" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactPasswordOld" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactPasswordDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ContactPasswordExpires" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ContactPasswordExpiresDate" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactSource" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactIndustry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactRegion" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactNotes" => [
"dbType" => "varchar(250)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactCallingRestrictions" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"LeadID" => "Lead ID",
"ContactID" => "Contact ID",
"LeadType" => "Lead Type",
"ContactDescription" => "Description",
"ContactLastName" => "Last Name",
"ContactFirstName" => "First Name",
"ContactTitle" => "Title",
"ContactPhone" => "Phone",
"ContactDepartment" => "ContactDepartment",
"ContactSalutation" => "ContactSalutation",
"ContactAddress1" => "ContactAddress1",
"ContactAddress2" => "ContactAddress2",
"ContactAddress3" => "ContactAddress3",
"ContactCity" => "ContactCity",
"ContactState" => "ContactState",
"ContactZip" => "ContactZip",
"ContactCountry" => "ContactCountry",
"ContactPhone2" => "ContactPhone2",
"ContactPhone3" => "ContactPhone3",
"ContactFax" => "ContactFax",
"ContactCellular" => "ContactCellular",
"ContactPager" => "ContactPager",
"ContactEmail" => "ContactEmail",
"ContactWebPage" => "ContactWebPage",
"ContactLogin" => "ContactLogin",
"ContactPassword" => "ContactPassword",
"ContactPasswordOld" => "ContactPasswordOld",
"ContactPasswordDate" => "ContactPasswordDate",
"ContactPasswordExpires" => "ContactPasswordExpires",
"ContactPasswordExpiresDate" => "ContactPasswordExpiresDate",
"ContactSource" => "ContactSource",
"ContactIndustry" => "ContactIndustry",
"ContactRegion" => "ContactRegion",
"ContactNotes" => "ContactNotes",
"ContactCallingRestrictions" => "ContactCallingRestrictions"];
}?>
