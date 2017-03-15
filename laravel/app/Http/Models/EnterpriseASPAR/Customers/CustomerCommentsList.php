<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customercomments";
protected $gridFields =["CustomerID","CommentLineID","CommentDate","CommentType","Comment"];
public $dashboardTitle ="Customer Comments";
public $breadCrumbTitle ="Customer Comments";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","CommentLineID"];
public $editCategories = [
"Main" => [

"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommentLineID" => [
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

"CustomerID" => "Customer ID",
"CommentLineID" => "Line ID",
"CommentDate" => "Comment Date",
"CommentType" => "Comment Type",
"Comment" => "Comment"];
}?>
