<?php

/*
Name of Page: PayrollEmployeeEmailMessageList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeeEmailMessageList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeeEmailMessageList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeeEmailMessageList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeeEmailMessageList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollEmployeeEmailMessageList extends gridDataSource{
public $tableName = "payrollemployeeemailmessage";
public $dashboardTitle ="PayrollEmployeeEmailMessage";
public $breadCrumbTitle ="PayrollEmployeeEmailMessage";
public $idField ="EmailMessageID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmailMessageID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmailMessageID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CommunicationType" => [
    "dbType" => "varchar(12)",
    "inputType" => "text"
],
"Status" => [
    "dbType" => "varchar(12)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmailMessageID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CommunicationType" => [
"dbType" => "varchar(12)",
"inputType" => "text",
"defaultValue" => ""
],
"Status" => [
"dbType" => "varchar(12)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"EmailMessageID" => "Message ID",
"CommunicationType" => "Communication Type",
"Status" => "Status"];
}?>
