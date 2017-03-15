<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendorcomments";
public $dashboardTitle ="Vendor Comments";
public $breadCrumbTitle ="Vendor Comments";
public $idField ="VendorID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID","CommentLineID"];
public $gridFields = [

"VendorID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CommentLineID" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"CommentTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CommentDate" => [
    "dbType" => "timestamp",
    "inputType" => "datetime"
],
"Comment" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"VendorID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CommentLineID" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"CommentDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CommentTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Comment" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"VendorID" => "Vendor ID",
"CommentLineID" => "Comment Line ID",
"CommentTypeID" => "Comment Type ID",
"CommentDate" => "Comment Date",
"Comment" => "Comment"];
}?>
