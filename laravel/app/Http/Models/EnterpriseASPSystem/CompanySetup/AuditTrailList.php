<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "audittrail";
public $gridFields =["AuditID","EmployeeID","EntryDate","EntryTime","DocumentType","TransactionNumber"];
public $dashboardTitle ="Audit Trail";
public $breadCrumbTitle ="Audit Trail";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","AuditID"];
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
"inputType" => "datetime",
"defaultValue" => "now"
],
"EntryTime" => [
"inputType" => "datetime",
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

"AuditID" => "Audit ID",
"EmployeeID" => "Employee ID",
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
