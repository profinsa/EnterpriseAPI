<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorywishlist";
protected $gridFields =["ItemID","CustomerID","WishQuantity","WishDate"];
public $dashboardTitle ="InventoryWishList ";
public $breadCrumbTitle ="InventoryWishList ";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID","CustomerID"];
public $editCategories = [
"Main" => [

"ItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WishQuantity" => [
"inputType" => "text",
"defaultValue" => ""
],
"WishDate" => [
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
