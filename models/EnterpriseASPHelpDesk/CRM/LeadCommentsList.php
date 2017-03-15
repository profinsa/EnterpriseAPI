<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "leadcomments";
protected $gridFields =["LeadID","CommentNumber","CommentDate","CommentType","Comment"];
public $dashboardTitle ="Lead Comments";
public $breadCrumbTitle ="Lead Comments";
public $idField ="CommentNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CommentNumber"];
public $editCategories = [
"Main" => [

"CommentNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommentDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"CommentType" => [
"inputType" => "text",
"defaultValue" => ""
],
"Comment" => [
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
