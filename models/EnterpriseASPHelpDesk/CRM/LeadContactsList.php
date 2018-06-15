<?php

/*
Name of Page: LeadContactsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadContactsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/LeadContactsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadContactsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadContactsList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "leadcontacts";
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
"ContactDepartment" => "Contact Department",
"ContactSalutation" => "Contact Salutation",
"ContactAddress1" => "Contact Address 1",
"ContactAddress2" => "Contact Address 2",
"ContactAddress3" => "Contact Address 3",
"ContactCity" => "Contact City",
"ContactState" => "Contact State",
"ContactZip" => "Contact Zip",
"ContactCountry" => "Contact Country",
"ContactPhone2" => "Contact Phone 2",
"ContactPhone3" => "Contact Phone 3",
"ContactFax" => "Contact Fax",
"ContactCellular" => "Contact Cellular",
"ContactPager" => "Contact Pager",
"ContactEmail" => "Contact Email",
"ContactWebPage" => "Contact Web Page",
"ContactLogin" => "Contact Login",
"ContactPassword" => "Contact Password",
"ContactPasswordOld" => "Contact Password Old",
"ContactPasswordDate" => "Contact Password Date",
"ContactPasswordExpires" => "Contact Password Expires",
"ContactPasswordExpiresDate" => "Contact Password Expires Date",
"ContactSource" => "Contact Source",
"ContactIndustry" => "Contact Industry",
"ContactRegion" => "Contact Region",
"ContactNotes" => "Contact Notes",
"ContactCallingRestrictions" => "Contact Calling Restrictions"];
}?>
