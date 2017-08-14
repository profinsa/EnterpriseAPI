<?php

/*
Name of Page: CustomerAccountStatusesList model
 
Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerAccountStatusesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/CustomerAccountStatusesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerAccountStatusesList.php
used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Customers\CustomerAccountStatusesList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/

 require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customeraccountstatuses";
public $dashboardTitle ="Customer Account Statuses";
public $breadCrumbTitle ="Customer Account Statuses";
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

"AccountStatus" => "Account Status ID",
"AccountStatusDescription" => "Account Status Description"];
}?>
