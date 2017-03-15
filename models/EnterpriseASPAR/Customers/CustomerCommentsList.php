<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customercomments";
public $dashboardTitle ="Customer Comments";
public $breadCrumbTitle ="Customer Comments";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","CommentLineID"];
public $gridFields = [

"CustomerID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CommentLineID" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"CommentDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"CommentType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"Comment" => [
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
"CommentLineID" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"CommentDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CommentType" => [
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

"CustomerID" => "Customer ID",
"CommentLineID" => "Line ID",
"CommentDate" => "Comment Date",
"CommentType" => "Comment Type",
"Comment" => "Comment"];
}?>
