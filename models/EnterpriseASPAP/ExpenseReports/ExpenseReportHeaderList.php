<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "expensereportheader";
protected $gridFields =["ExpenseReportID","ExpenseReportType","ExpenseReportDate","ExpenseReportForEmployee","ExpenseReportReason","ExpenseReportTotal","ExpenseReportDueEmployee","ExpenseReportPaymentID"];
public $dashboardTitle ="ExpenseReportHeader";
public $breadCrumbTitle ="ExpenseReportHeader";
public $idField ="ExpenseReportID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ExpenseReportID"];
public $editCategories = [
"Main" => [

"ExpenseReportID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportType" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ExpenseReportForEmployee" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportReason" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportTotal" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportAdvances" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportDueEmployee" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportPaid" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportPaidDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ExpenseReportPaymentID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportApproved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportApprovedDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ExpenseReportMemo1" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo2" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo3" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo4" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo5" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo6" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo7" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo8" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo9" => [
"inputType" => "text",
"defaultValue" => ""
],
"ExpenseReportMemo10" => [
"inputType" => "text",
"defaultValue" => ""
],
"Signature" => [
"inputType" => "text",
"defaultValue" => ""
],
"SignaturePassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorSignature" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorPassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"ManagerSignature" => [
"inputType" => "text",
"defaultValue" => ""
],
"ManagerPassword" => [
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
