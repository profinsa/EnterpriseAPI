<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "warehousescontacts";
public $dashboardTitle ="WarehousesContacts";
public $breadCrumbTitle ="WarehousesContacts";
public $idField ="WarehouseID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WarehouseID","ContactID"];
public $gridFields = [

"WarehouseID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactTypeID" => [
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
"ContactAddress1" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ContactAddress2" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ContactAddress3" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ContactCity" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ContactState" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ContactZip" => [
    "dbType" => "varchar(10)",
    "inputType" => "text"
],
"ContactPhone" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
],
"ContactFax" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
],
"ContactCellular" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
],
"ContactPager" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
],
"ContactEmail" => [
    "dbType" => "varchar(60)",
    "inputType" => "text"
],
"ContactWebPage" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"ContactLogin" => [
    "dbType" => "varchar(60)",
    "inputType" => "text"
],
"ContactPassword" => [
    "dbType" => "varchar(20)",
    "inputType" => "text"
],
"ContactPasswordOld" => [
    "dbType" => "varchar(15)",
    "inputType" => "text"
],
"ContactPasswordDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"ContactPasswordExpiresDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"ContactRegion" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ContactNotes" => [
    "dbType" => "varchar(250)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WarehouseID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactTypeID" => [
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
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactPhone" => [
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
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
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
