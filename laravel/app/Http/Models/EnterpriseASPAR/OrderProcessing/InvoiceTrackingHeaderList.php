<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
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
"inputType" => "datepicker",
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
"inputType" => "datepicker",
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
