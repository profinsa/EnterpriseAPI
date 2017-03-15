<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryreviews";
public $gridFields =["ItemID","ReviewID","ReviewBy","ReviewDate","Rating","Helpful","ApprovedBy"];
public $dashboardTitle ="InventoryReviews";
public $breadCrumbTitle ="InventoryReviews";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","ReviewID"];
public $editCategories = [
"Main" => [

"ItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReviewID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReviewBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReviewDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Review" => [
"inputType" => "text",
"defaultValue" => ""
],
"Rating" => [
"inputType" => "text",
"defaultValue" => ""
],
"Helpful" => [
"inputType" => "text",
"defaultValue" => ""
],
"Views" => [
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"ReviewID" => "Review ID",
"ReviewBy" => "Review By",
"ReviewDate" => "Review Date",
"Rating" => "Rating",
"Helpful" => "Helpful",
"ApprovedBy" => "Approved By",
"Review" => "Review",
"Views" => "Views",
"Approved" => "Approved"];
}?>
