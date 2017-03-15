<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customercontacts";
protected $gridFields =["CustomerID","ContactID","ContactType","ContactLastName","ContactFirstName","ContactPhone"];
public $dashboardTitle ="Customer Contacts";
public $breadCrumbTitle ="Customer Contacts";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ContactID"];
public $editCategories = [
"Main" => [

"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactType" => [
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
"ContactSource" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactSalutation" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactIndustry" => [
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
"inputType" => "datetime",
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

"CustomerID" => "Customer ID",
"ContactID" => "Contact ID",
"ContactType" => "Contact Type",
"ContactLastName" => "Contact Last Name",
"ContactFirstName" => "Contact First Name",
"ContactPhone" => "Contact Phone",
"ContactDescription" => "ContactDescription",
"ContactTitle" => "ContactTitle",
"ContactDepartment" => "ContactDepartment",
"ContactSource" => "ContactSource",
"ContactSalutation" => "ContactSalutation",
"ContactIndustry" => "ContactIndustry",
"ContactAddress1" => "ContactAddress1",
"ContactAddress2" => "ContactAddress2",
"ContactAddress3" => "ContactAddress3",
"ContactCity" => "ContactCity",
"ContactState" => "ContactState",
"ContactZip" => "ContactZip",
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
"ContactRegion" => "ContactRegion",
"ContactNotes" => "ContactNotes",
"ContactCallingRestrictions" => "ContactCallingRestrictions"];
}?>
