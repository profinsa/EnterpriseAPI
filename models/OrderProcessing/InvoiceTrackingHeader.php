<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "invoicetrackingheader";
protected $gridFields =["InvoiceNumber","InvoiceDescription","EnteredBy"];
public $dashboardTitle ="InvoiceTrackingHeader";
public $breadCrumbTitle ="InvoiceTrackingHeader";
public $idField ="InvoiceNumber";
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
"inputType" => "text",
"defaultValue" => ""
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
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"InvoiceNumber" => "Invoice Number",
"InvoiceDescription" => "Invoice Description",
"EnteredBy" => "Entered By",
"PaymentExpectedBy" => "Payment Expected By",
"PaymentProblemReason" => "Payment Problem Reason",
"ApprovedDate" => "Approved Date",
"InvoiceLongDescription" => "InvoiceLongDescription",
"PaymentProblem" => "PaymentProblem",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy"];
}?>
