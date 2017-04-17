<?php

/*
Name of Page: ExpenseReportHeaderHistoryList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\ExpenseReports\ExpenseReportHeaderHistoryList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ExpenseReportHeaderHistoryList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\ExpenseReports\ExpenseReportHeaderHistoryList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\ExpenseReports\ExpenseReportHeaderHistoryList.php
 
Calls:
MySql Database
 
Last Modified: 04/13/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "expensereportheaderhistory";
public $dashboardTitle ="ExpenseReportHeaderHistory";
public $breadCrumbTitle ="ExpenseReportHeaderHistory";
public $idField ="ExpenseReportID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ExpenseReportID"];
public $gridFields = [

"ExpenseReportID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ExpenseReportType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ExpenseReportDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"ExpenseReportForEmployee" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ExpenseReportReason" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ExpenseReportTotal" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"ExpenseReportDueEmployee" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"ExpenseReportPaymentID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ExpenseReportID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ExpenseReportForEmployee" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportReason" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportTotal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportAdvances" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportDueEmployee" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportPaid" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ExpenseReportPaidDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ExpenseReportPaymentID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportApproved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ExpenseReportApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ExpenseReportMemo1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo3" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo4" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo5" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo6" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo7" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo8" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo9" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo10" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Signature" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SignaturePassword" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorSignature" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorPassword" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ManagerSignature" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ManagerPassword" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ExpenseReportID" => "Report ID",
"ExpenseReportType" => "Type",
"ExpenseReportDate" => "Date",
"ExpenseReportForEmployee" => "For Employee",
"ExpenseReportReason" => "Reason",
"ExpenseReportTotal" => "Total",
"ExpenseReportDueEmployee" => "Due Employee",
"ExpenseReportPaymentID" => "Payment ID",
"ExpenseReportDescription" => "Expense Report Description",
"ExpenseReportAdvances" => "Expense Report Advances",
"ExpenseReportPaid" => "Expense Report Paid",
"ExpenseReportPaidDate" => "Expense Report Paid Date",
"ExpenseReportApproved" => "Expense Report Approved",
"ExpenseReportApprovedBy" => "Expense Report Approved By",
"ExpenseReportApprovedDate" => "Expense Report Approved Date",
"ExpenseReportMemo1" => "Expense Report Memo 1",
"ExpenseReportMemo2" => "Expense Report Memo 2",
"ExpenseReportMemo3" => "Expense Report Memo 3",
"ExpenseReportMemo4" => "Expense Report Memo 4",
"ExpenseReportMemo5" => "Expense Report Memo 5",
"ExpenseReportMemo6" => "Expense Report Memo 6",
"ExpenseReportMemo7" => "Expense Report Memo 7",
"ExpenseReportMemo8" => "Expense Report Memo 8",
"ExpenseReportMemo9" => "Expense Report Memo 9",
"ExpenseReportMemo10" => "Expense Report Memo 10",
"Signature" => "Signature",
"SignaturePassword" => "Signature Password",
"SupervisorSignature" => "Supervisor Signature",
"SupervisorPassword" => "Supervisor Password",
"ManagerSignature" => "Manager Signature",
"ManagerPassword" => "Manager Password"];
}?>
