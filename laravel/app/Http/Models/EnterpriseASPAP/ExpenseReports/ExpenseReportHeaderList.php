<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "expensereportheader";
public $dashboardTitle ="ExpenseReportHeader";
public $breadCrumbTitle ="ExpenseReportHeader";
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
    "inputType" => "text"
],
"ExpenseReportDueEmployee" => [
    "dbType" => "decimal(19,4)",
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
"inputType" => "text",
"defaultValue" => ""
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
"inputType" => "text",
"defaultValue" => ""
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
"ExpenseReportDescription" => "ExpenseReportDescription",
"ExpenseReportAdvances" => "ExpenseReportAdvances",
"ExpenseReportPaid" => "ExpenseReportPaid",
"ExpenseReportPaidDate" => "ExpenseReportPaidDate",
"ExpenseReportApproved" => "ExpenseReportApproved",
"ExpenseReportApprovedBy" => "ExpenseReportApprovedBy",
"ExpenseReportApprovedDate" => "ExpenseReportApprovedDate",
"ExpenseReportMemo1" => "ExpenseReportMemo1",
"ExpenseReportMemo2" => "ExpenseReportMemo2",
"ExpenseReportMemo3" => "ExpenseReportMemo3",
"ExpenseReportMemo4" => "ExpenseReportMemo4",
"ExpenseReportMemo5" => "ExpenseReportMemo5",
"ExpenseReportMemo6" => "ExpenseReportMemo6",
"ExpenseReportMemo7" => "ExpenseReportMemo7",
"ExpenseReportMemo8" => "ExpenseReportMemo8",
"ExpenseReportMemo9" => "ExpenseReportMemo9",
"ExpenseReportMemo10" => "ExpenseReportMemo10",
"Signature" => "Signature",
"SignaturePassword" => "SignaturePassword",
"SupervisorSignature" => "SupervisorSignature",
"SupervisorPassword" => "SupervisorPassword",
"ManagerSignature" => "ManagerSignature",
"ManagerPassword" => "ManagerPassword"];
}?>
