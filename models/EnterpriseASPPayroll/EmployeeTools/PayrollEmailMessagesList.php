<?php

/*
Name of Page: PayrollEmailMesageList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmailMesageList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmailMesageList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmailMesageList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmailMesageList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollEmailMessagesList extends gridDataSource{
public $tableName = "payrollemailmessages";
public $dashboardTitle ="PayrollEmailMessages";
public $breadCrumbTitle ="PayrollEmailMessages";
public $idField ="EmailMessageID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmailMessageID"];
public $gridFields = [

"EmailMessageID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"Sender" => [
    "dbType" => "varchar(60)",
    "inputType" => "text"
],
"CCTo" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"Subject" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
],
"Priority" => [
    "dbType" => "smallint(6)",
    "inputType" => "text"
],
"TimeSent" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"EmailMessageID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Body" => [
"dbType" => "longtext",
"inputType" => "text",
"defaultValue" => ""
],
"Sender" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"CCTo" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"Subject" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"Priority" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
],
"TimeSent" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"EmailMessageID" => "Message ID",
"Sender" => "Sender",
"CCTo" => "CC To",
"Subject" => "Subject",
"Priority" => "Priority",
"TimeSent" => "Time Sent",
"Body" => "Body"];
}?>
