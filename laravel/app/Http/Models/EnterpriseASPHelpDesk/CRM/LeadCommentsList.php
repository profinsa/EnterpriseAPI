<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "leadcomments";
public $dashboardTitle ="Lead Comments";
public $breadCrumbTitle ="Lead Comments";
public $idField ="CommentNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CommentNumber"];
public $gridFields = [

"LeadID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CommentNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CommentDate" => [
    "dbType" => "timestamp",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"CommentType" => [
    "dbType" => "varchar(15)",
    "inputType" => "text"
],
"Comment" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"CommentNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"LeadID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CommentDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CommentType" => [
"dbType" => "varchar(15)",
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

"LeadID" => "Lead ID",
"CommentNumber" => "Comment Number",
"CommentDate" => "Comment Date",
"CommentType" => "Comment Type",
"Comment" => "Comment"];
}?>
