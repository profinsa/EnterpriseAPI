<?php

/*
Name of Page: VendorContactsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorContactsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/VendorContactsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorContactsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorContactsList.php
 
Calls:
MySql Database
 
Last Modified: 04/13/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "vendorcontacts";
public $dashboardTitle ="Vendor Contacts";
public $breadCrumbTitle ="Vendor Contacts";
public $idField ="VendorID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID","ContactID"];
public $gridFields = [

"VendorID" => [
    "dbType" => "varchar(50)",
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
"ContactFirstName" => [
    "dbType" => "varchar(20)",
    "inputType" => "text"
],
"ContactLastName" => [
    "dbType" => "varchar(20)",
    "inputType" => "text"
],
"ContactPhone" => [
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
]
];

public $editCategories = [
"Main" => [

"VendorID" => [
"dbType" => "varchar(50)",
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
]
]];
public $columnNames = [

"VendorID" => "Vendor ID",
"ContactID" => "Contact ID",
"ContactTypeID" => "Contact Type ID",
"ContactFirstName" => "First Name",
"ContactLastName" => "Last Name",
"ContactPhone" => "Phone",
"ContactEmail" => "Email",
"ContactWebPage" => "Web Page",
"ContactDescription" => "Contact Description",
"ContactAddress1" => "Contact Address 1",
"ContactAddress2" => "Contact Address 2",
"ContactAddress3" => "Contact Address 3",
"ContactCity" => "Contact City",
"ContactState" => "Contact State",
"ContactZip" => "Contact Zip",
"ContactFax" => "Contact Fax",
"ContactCellular" => "Contact Cellular",
"ContactPager" => "Contact Pager",
"ContactLogin" => "Contact Login",
"ContactPassword" => "Contact Password",
"ContactPasswordOld" => "Contact Password Old",
"ContactPasswordDate" => "Contact Password Date",
"ContactPasswordExpires" => "Contact Password Expires",
"ContactPasswordExpiresDate" => "Contact Password Expires Date",
"ContactRegion" => "Contact Region",
"ContactNotes" => "Contact Notes"];
}?>
