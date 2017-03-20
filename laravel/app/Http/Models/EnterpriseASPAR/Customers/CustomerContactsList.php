<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customercontacts";
public $dashboardTitle ="Customer Contacts";
public $breadCrumbTitle ="Customer Contacts";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ContactID"];
public $gridFields = [

"CustomerID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ContactID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactType" => [
    "dbType" => "varchar(36)",
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
"ContactPhone" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"CustomerID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactType" => [
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
"ContactSource" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactSalutation" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactIndustry" => [
"dbType" => "varchar(50)",
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
