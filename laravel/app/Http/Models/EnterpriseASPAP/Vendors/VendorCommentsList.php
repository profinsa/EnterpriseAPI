<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "vendorcomments";
protected $gridFields =["VendorID","CommentLineID","CommentTypeID","CommentDate","Comment"];
public $dashboardTitle ="Vendor Comments";
public $breadCrumbTitle ="Vendor Comments";
public $idField ="VendorID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID","CommentLineID"];
public $editCategories = [
"Main" => [

"VendorID" => [
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
"CommentTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"Comment" => [
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
