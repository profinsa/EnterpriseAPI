<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "invoicetrackingheader";
public $gridFields =["InvoiceNumber","InvoiceDescription","EnteredBy"];
public $dashboardTitle ="InvoiceTrackingHeader";
public $breadCrumbTitle ="InvoiceTrackingHeader";
public $idField ="InvoiceNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","InvoiceNumber"];
public $editCategories = [
"Main" => [

"InvoiceNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceLongDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentExpectedBy" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"PaymentProblem" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentProblemReason" => [
"inputType" => "text",
"defaultValue" => ""
],
"EnteredBy" => [
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
]
]];
public $columnNames = [

"InvoiceNumber" => "Invoice Number",
"InvoiceDescription" => "Invoice Description",
"EnteredBy" => "Entered By",
"InvoiceLongDescription" => "InvoiceLongDescription",
"PaymentExpectedBy" => "PaymentExpectedBy",
"PaymentProblem" => "PaymentProblem",
"PaymentProblemReason" => "PaymentProblemReason",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate"];
}?>
