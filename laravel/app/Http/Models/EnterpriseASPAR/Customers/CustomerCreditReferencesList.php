<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customercreditreferences";
public $dashboardTitle ="Customer Credit References";
public $breadCrumbTitle ="Customer Credit References";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ReferenceID"];
public $gridFields = [

"CustomerID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ReferenceID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReferenceName" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
],
"ReferenceDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"ReferenceSoldSince" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"ReferenceHighCredit" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"CustomerID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceName" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ReferenceFactor" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceSoldSince" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ReferenceLastSale" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ReferenceHighCredit" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceCurrentBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ReferencePastDue" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ReferencePromptPerc" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceLateDays" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceFutures" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceComments" => [
"dbType" => "varchar(250)",
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
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"ReferenceID" => "Reference ID",
"ReferenceName" => "Reference Name",
"ReferenceDate" => "Reference Date",
"ReferenceSoldSince" => "Reference Sold Since",
"ReferenceHighCredit" => "Reference High Credit",
"ReferenceFactor" => "ReferenceFactor",
"ReferenceLastSale" => "ReferenceLastSale",
"ReferenceCurrentBalance" => "ReferenceCurrentBalance",
"ReferencePastDue" => "ReferencePastDue",
"ReferencePromptPerc" => "ReferencePromptPerc",
"ReferenceLateDays" => "ReferenceLateDays",
"ReferenceFutures" => "ReferenceFutures",
"ReferenceComments" => "ReferenceComments",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"EnteredBy" => "EnteredBy"];
}?>
