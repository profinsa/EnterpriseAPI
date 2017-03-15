<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryadjustments";
protected $gridFields =["AdjustmentID","AdjustmentTypeID","AdjustmentDate","AdjustmentReason","AdjustmentPosted"];
public $dashboardTitle ="Inventory Adjustments";
public $breadCrumbTitle ="Inventory Adjustments";
public $idField ="AdjustmentID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AdjustmentID"];
public $editCategories = [
"Main" => [

"AdjustmentID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"SystemDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"AdjustmentReason" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentPosted" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdjustmentPostToGL" => [
"inputType" => "text",
"defaultValue" => ""
],
"BatchControlNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"BatchControlTotal" => [
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
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
],
"Total" => [
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
