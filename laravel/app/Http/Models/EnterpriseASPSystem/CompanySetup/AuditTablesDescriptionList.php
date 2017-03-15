<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "audittablesdescription";
public $dashboardTitle ="AuditTablesDescription";
public $breadCrumbTitle ="AuditTablesDescription";
public $idField ="undefined";
public $idFields = ["TableName"];
public $gridFields = [

"TableName" => [
    "dbType" => "varchar(128)",
    "inputType" => "text"
],
"DocumentType" => [
    "dbType" => "varchar(128)",
    "inputType" => "text"
],
"TransactionNumberField" => [
    "dbType" => "varchar(128)",
    "inputType" => "text"
],
"TransactionLineNumberField" => [
    "dbType" => "varchar(128)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TableName" => [
"dbType" => "varchar(128)",
"inputType" => "text",
"defaultValue" => ""
],
"DocumentType" => [
"dbType" => "varchar(128)",
"inputType" => "text",
"defaultValue" => ""
],
"TransactionNumberField" => [
"dbType" => "varchar(128)",
"inputType" => "text",
"defaultValue" => ""
],
"TransactionLineNumberField" => [
"dbType" => "varchar(128)",
"inputType" => "text",
"defaultValue" => ""
],
"ComplexObject" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApplyAudit" => [
"dbType" => "tinyint(1)",
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
