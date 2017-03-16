<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customercontactlog";
public $dashboardTitle ="Customer Contact Log";
public $breadCrumbTitle ="Customer Contact Log";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ContactID","ContactLogID"];
public $gridFields = [

"CustomerID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ContactID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactLogID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactDate" => [
    "dbType" => "timestamp",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"ContactDesctiption" => [
    "dbType" => "varchar(255)",
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
"ContactID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactLogID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ContactCallStartTime" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ContactCallEndTime" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ContactDesctiption" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"ContactID" => "Contact ID",
"ContactLogID" => "Contact Log ID",
"ContactDate" => "Contact Date",
"ContactDesctiption" => "Contact Desctiption",
"ContactCallStartTime" => "ContactCallStartTime",
"ContactCallEndTime" => "ContactCallEndTime"];
}?>
