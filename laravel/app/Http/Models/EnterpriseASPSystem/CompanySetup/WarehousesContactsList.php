<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehousescontacts";
protected $gridFields =["WarehouseID","ContactID","ContactTypeID","ContactDescription","ContactLastName","ContactFirstName","ContactAddress1","ContactAddress2","ContactAddress3","ContactCity","ContactState","ContactZip","ContactPhone","ContactFax","ContactCellular","ContactPager","ContactEmail","ContactWebPage","ContactLogin","ContactPassword","ContactPasswordOld","ContactPasswordDate","ContactPasswordExpiresDate","ContactRegion","ContactNotes"];
public $dashboardTitle ="WarehousesContacts";
public $breadCrumbTitle ="WarehousesContacts";
public $idField ="WarehouseID";
public $editCategories = [
"Main" => [

"WarehouseID" => [
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
"inputType" => "datepicker",
"defaultValue" => "now"
],
"ContactPasswordExpires" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactPasswordExpiresDate" => [
"inputType" => "datepicker",
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

"WarehouseID" => "Warehouse ID",
"ContactID" => "Contact ID",
"ContactTypeID" => "Contact Type ID",
"ContactDescription" => "Contact Description",
"ContactLastName" => "Last Name",
"ContactFirstName" => "First Name",
"ContactAddress1" => "Address 1",
"ContactAddress2" => "Address 2",
"ContactAddress3" => "Address 3",
"ContactCity" => "City",
"ContactState" => "State",
"ContactZip" => "Zip",
"ContactPhone" => "Phone",
"ContactFax" => "Fax",
"ContactCellular" => "Cellular",
"ContactPager" => "Pager",
"ContactEmail" => "Email",
"ContactWebPage" => "Web Page",
"ContactLogin" => "Login",
"ContactPassword" => "Password",
"ContactPasswordOld" => "Password Old",
"ContactPasswordDate" => "Password Date",
"ContactPasswordExpiresDate" => "Password ExpiresDate",
"ContactRegion" => "Region",
"ContactNotes" => "Notes",
"ContactPasswordExpires" => "ContactPasswordExpires"];
}?>
