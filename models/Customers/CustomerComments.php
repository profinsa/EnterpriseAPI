<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customercomments";
protected $gridFields =["CustomerID","CommentLineID","CommentDate","CommentType","Comment"];
public $dashboardTitle ="Customer Comments";
public $breadCrumbTitle ="Customer Comments";
public $idField ="CustomerID";
public $editCategories = [
"Main" => [

"CommentLineID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommentDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"Comment" => [
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
