<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customercontacts";
protected $gridFields =["CustomerID","ContactID","ContactType","ContactLastName","ContactFirstName","ContactPhone"];
public $dashboardTitle ="Customer Contacts";
public $breadCrumbTitle ="Customer Contacts";
public $idField ="CustomerID";
public $editCategories = [
"Main" => [

"ContactID" => [
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
"ContactSalutation" => [
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
"ContactDepartment" => [
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
],
"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactLogID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactCallStartTime" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactCallEndTime" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactDesctiption" => [
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
"ContactDescription" => "Contact Description",
"ContactTitle" => "Contact Title",
"ContactSalutation" => "Contact Salutation",
"ContactLogin" => "Contact Login",
"ContactPassword" => "Contact Password",
"ContactAddress1" => "Contact Address 1",
"ContactAddress2" => "Contact Address 2",
"ContactAddress3" => "Contact Address 3",
"ContactCity" => "Contact City",
"ContactState" => "Contact State",
"ContactZip" => "Contact Zip",
"ContactPhone2" => "Contact Phone 2",
"ContactPhone3" => "Contact Phone 3",
"ContactFax" => "Contact Fax",
"ContactCellular" => "Contact Cellular",
"ContactPager" => "Contact Pager",
"ContactEmail" => "Contact Email",
"ContactWebPage" => "Contact Web Page",
"ContactDepartment" => "Contact Department",
"ContactNotes" => "Notes",
"ContactCallingRestrictions" => "Calling Restrictions",
"ContactLogID" => "Contact Log ID",
"ContactDate" => "Contact Date",
"ContactCallStartTime" => "Call Start Time",
"ContactCallEndTime" => "Call End Time",
"ContactDesctiption" => "Desctiption"];
}?>
