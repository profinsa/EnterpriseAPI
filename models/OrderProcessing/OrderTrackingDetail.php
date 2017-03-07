<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ordertrackingdetail"
;protected $gridFields =["OrderNumber","CommentNumber","CommentDate","Comment","CommentDetails","ApprovedBy","ApprovedDate"];
public $dashboardTitle ="OrderTrackingDetail";
public $breadCrumbTitle ="OrderTrackingDetail";
public $idField ="OrderNumber";
public $editCategories = [
"Main" => [

"OrderNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommentNumber" => [
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
],
"CommentDetails" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"OrderNumber" => "Order Number",
"CommentNumber" => "Comment Number",
"CommentDate" => "Comment Date",
"Comment" => "Comment",
"CommentDetails" => "Comment Details",
"ApprovedBy" => "Approved By",
"ApprovedDate" => "Approved Date"];
}?>
