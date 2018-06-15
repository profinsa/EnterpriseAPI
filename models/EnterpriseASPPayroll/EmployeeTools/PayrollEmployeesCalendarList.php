<?php

/*
Name of Page: PayrollEmployeesCalenderList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeesCalenderList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeesCalenderList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeesCalenderList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeTools\PayrollEmployeesCalenderList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "payrollemployeescalendar";
public $dashboardTitle ="PayrollEmployeesCalendar";
public $breadCrumbTitle ="PayrollEmployeesCalendar";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","AppointmenStart"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AppointmenStart" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"AppointmentEnd" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"AppointmentReason" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"RelatedTaskID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"RelatedCustomerID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"RelatedLeadID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"RelatedVendorID" => [
    "dbType" => "varchar(36)",
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
"AppointmenStart" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"AppointmentEnd" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"AppointmentReason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"AppointmentDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedTaskID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedDocumentID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedCustomerID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedLeadID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedVendorID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AppointmentNotes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"RequestedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"AppointmenStart" => "Appointmen Start",
"AppointmentEnd" => "Appointment End",
"AppointmentReason" => "Appointment Reason",
"RelatedTaskID" => "RelatedTask ID",
"RelatedCustomerID" => "Related Customer ID",
"RelatedLeadID" => "Related Lead ID",
"RelatedVendorID" => "Related Vendor ID",
"AppointmentDescription" => "Appointment Description",
"RelatedDocumentID" => "Related Document ID",
"AppointmentNotes" => "Appointment Notes",
"RequestedBy" => "Requested By"];
}?>
