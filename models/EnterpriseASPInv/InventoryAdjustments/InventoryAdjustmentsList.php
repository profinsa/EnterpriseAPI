<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryadjustments";
public $dashboardTitle ="Inventory Adjustments";
public $breadCrumbTitle ="Inventory Adjustments";
public $idField ="AdjustmentID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AdjustmentID"];
public $gridFields = [

"AdjustmentID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AdjustmentTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AdjustmentDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"AdjustmentReason" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"AdjustmentPosted" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"AdjustmentID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"SystemDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"AdjustmentReason" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentPosted" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentNotes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentPostToGL" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"BatchControlNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"BatchControlTotal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"dbType" => "varchar(36)",
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
],
"Total" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AdjustmentID" => "Adjustment ID",
"AdjustmentTypeID" => "Adjustment Type ID",
"AdjustmentDate" => "Adjustment Date",
"AdjustmentReason" => "Adjustment Reason",
"AdjustmentPosted" => "Adjustment Posted",
"SystemDate" => "SystemDate",
"AdjustmentNotes" => "AdjustmentNotes",
"AdjustmentPostToGL" => "AdjustmentPostToGL",
"BatchControlNumber" => "BatchControlNumber",
"BatchControlTotal" => "BatchControlTotal",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"EnteredBy" => "EnteredBy",
"Signature" => "Signature",
"SignaturePassword" => "SignaturePassword",
"SupervisorSignature" => "SupervisorSignature",
"SupervisorPassword" => "SupervisorPassword",
"ManagerSignature" => "ManagerSignature",
"ManagerPassword" => "ManagerPassword",
"Total" => "Total"];
}?>
