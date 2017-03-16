<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "audittrailhistory";
public $dashboardTitle ="Audit Trail History";
public $breadCrumbTitle ="Audit Trail History";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","AuditID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AuditID" => [
    "dbType" => "bigint(20)",
    "inputType" => "text"
],
"EntryDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"EntryTime" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"DocumentType" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TransactionNumber" => [
    "dbType" => "varchar(50)",
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
"AuditID" => [
"dbType" => "bigint(20)",
"inputType" => "text",
"defaultValue" => ""
],
"EntryDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EntryTime" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"DocumentType" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TransactionNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TableAffected" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"FieldChanged" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"OldValue" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"NewValue" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"TransactionLineNumber" => [
"dbType" => "varchar(50)",
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