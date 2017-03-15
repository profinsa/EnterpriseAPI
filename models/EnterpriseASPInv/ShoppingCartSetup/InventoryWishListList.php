<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorywishlist";
public $dashboardTitle ="InventoryWishList ";
public $breadCrumbTitle ="InventoryWishList ";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","CustomerID"];
public $gridFields = [

"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CustomerID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WishQuantity" => [
    "dbType" => "bigint(20)",
    "inputType" => "text"
],
"WishDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"ItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CustomerID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WishQuantity" => [
"dbType" => "bigint(20)",
"inputType" => "text",
"defaultValue" => ""
],
"WishDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"CustomerID" => "Customer ID",
"WishQuantity" => "Wish Quantity",
"WishDate" => "Wish Date"];
}?>
