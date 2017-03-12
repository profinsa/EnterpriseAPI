<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "audittrailhistory";
protected $gridFields =["EmployeeID","AuditID","EntryDate","EntryTime","DocumentType","TransactionNumber"];
public $dashboardTitle ="Audit Trail History";
public $breadCrumbTitle ="Audit Trail History";
public $idField ="EmployeeID";
public $editCategories = [
"Main" => [

"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AuditID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EntryDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"EntryTime" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"DocumentType" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"TableAffected" => [
"inputType" => "text",
"defaultValue" => ""
],
"FieldChanged" => [
"inputType" => "text",
"defaultValue" => ""
],
"OldValue" => [
"inputType" => "text",
"defaultValue" => ""
],
"NewValue" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionLineNumber" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"AuditID" => "Audit ID",
"EntryDate" => "Entry Date",
"EntryTime" => "Entry Time",
"DocumentType" => "Document Type",
"TransactionNumber" => "Transaction Number",
"TableAffected" => "TableAffected",
"FieldChanged" => "FieldChanged",
"OldValue" => "OldValue",
"NewValue" => "NewValue",
"TransactionLineNumber" => "TransactionLineNumber"];
}?>
