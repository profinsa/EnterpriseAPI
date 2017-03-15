<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "audittablesdescription";
public $gridFields =["TableName","DocumentType","TransactionNumberField","TransactionLineNumberField"];
public $dashboardTitle ="AuditTablesDescription";
public $breadCrumbTitle ="AuditTablesDescription";
public $idField ="undefined";
public $idFields = ["TableName"];
public $editCategories = [
"Main" => [

"TableName" => [
"inputType" => "text",
"defaultValue" => ""
],
"DocumentType" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionNumberField" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionLineNumberField" => [
"inputType" => "text",
"defaultValue" => ""
],
"ComplexObject" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApplyAudit" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"TableName" => "Table Name",
"DocumentType" => "Document Type",
"TransactionNumberField" => "Transaction Number Field",
"TransactionLineNumberField" => "Transaction LineNumber Field",
"ComplexObject" => "ComplexObject",
"ApplyAudit" => "ApplyAudit"];
}?>
