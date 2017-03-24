<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryreviews";
public $dashboardTitle ="InventoryReviews";
public $breadCrumbTitle ="InventoryReviews";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","ReviewID"];
public $gridFields = [

"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReviewID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReviewBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReviewDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"Rating" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"Helpful" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"ApprovedBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReviewID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReviewBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ReviewDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Review" => [
"dbType" => "varchar(999)",
"inputType" => "text",
"defaultValue" => ""
],
"Rating" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"Helpful" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"Views" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
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
