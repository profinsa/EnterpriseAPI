<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "leadcontacts";
protected $gridFields =["LeadID","ContactID","LeadType","ContactDescription","ContactLastName","ContactFirstName","ContactTitle","ContactPhone"];
public $dashboardTitle ="Lead Contacts";
public $breadCrumbTitle ="Lead Contacts";
public $idField ="LeadID";
public $editCategories = [
"Main" => [

"LeadID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactID" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadType" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactLastName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactFirstName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactTitle" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactDepartment" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactSalutation" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactAddress3" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactState" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactPhone2" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactPhone3" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactCellular" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactPager" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactWebPage" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactLogin" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactPassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactPasswordOld" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactPasswordDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"ContactPasswordExpires" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactPasswordExpiresDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactSource" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactIndustry" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactRegion" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactCallingRestrictions" => [
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
