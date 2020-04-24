<?php

/*
Name of Page: VendorAccountStatusesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorAccountStatusesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/VendorAccountStatusesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorAccountStatusesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorAccountStatusesList.php
 
Calls:
MySql Database
 
Last Modified: 04/13/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class VendorAccountStatusesList extends gridDataSource{
public $tableName = "vendoraccountstatuses";
public $dashboardTitle ="Vendor Account Statuses";
public $breadCrumbTitle ="Vendor Account Statuses";
public $idField ="AccountStatus";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AccountStatus"];
public $gridFields = [

"AccountStatus" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AccountStatusDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"AccountStatus" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AccountStatusDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AccountStatus" => "Account Status",
"AccountStatusDescription" => "Account Status Description"];
}?>
