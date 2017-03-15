<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "bankaccountscontacts";
protected $gridFields =["BankID","ContactID","ContactTypeID","ContactLastName","ContactFirstName","ContactPhone","ContactEmail"];
public $dashboardTitle ="BankAccountsContacts";
public $breadCrumbTitle ="BankAccountsContacts";
public $idField ="BankID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","BankID","ContactID"];
public $editCategories = [
"Main" => [

"BankID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactTypeID" => [
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
"inputType" => "datetime",
"defaultValue" => "now"
],
"ContactRegion" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactNotes" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"BankID" => "Bank ID",
"ContactID" => "Contact ID",
"ContactTypeID" => "Contact Type ID",
"ContactLastName" => "Last Name",
"ContactFirstName" => "First Name",
"ContactPhone" => "Phone",
"ContactEmail" => "Email",
"ContactDescription" => "ContactDescription",
"ContactAddress1" => "ContactAddress1",
"ContactAddress2" => "ContactAddress2",
"ContactAddress3" => "ContactAddress3",
"ContactCity" => "ContactCity",
"ContactState" => "ContactState",
"ContactZip" => "ContactZip",
"ContactFax" => "ContactFax",
"ContactCellular" => "ContactCellular",
"ContactPager" => "ContactPager",
"ContactWebPage" => "ContactWebPage",
"ContactLogin" => "ContactLogin",
"ContactPassword" => "ContactPassword",
"ContactPasswordOld" => "ContactPasswordOld",
"ContactPasswordDate" => "ContactPasswordDate",
"ContactPasswordExpires" => "ContactPasswordExpires",
"ContactPasswordExpiresDate" => "ContactPasswordExpiresDate",
"ContactRegion" => "ContactRegion",
"ContactNotes" => "ContactNotes"];
}?>
