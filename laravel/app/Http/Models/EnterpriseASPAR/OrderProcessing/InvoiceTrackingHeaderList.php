<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "invoicetrackingheader";
public $dashboardTitle ="InvoiceTrackingHeader";
public $breadCrumbTitle ="InvoiceTrackingHeader";
public $idField ="InvoiceNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","InvoiceNumber"];
public $gridFields = [

"InvoiceNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"InvoiceDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"EnteredBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"InvoiceNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"InvoiceLongDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"PaymentExpectedBy" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PaymentProblem" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"PaymentProblemReason" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"EnteredBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
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
