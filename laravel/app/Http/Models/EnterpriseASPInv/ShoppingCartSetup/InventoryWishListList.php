<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorywishlist";
protected $gridFields =["ItemID","CustomerID","WishQuantity","WishDate"];
public $dashboardTitle ="InventoryWishList ";
public $breadCrumbTitle ="InventoryWishList ";
public $idField ="ItemID";
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
"inputType" => "datepicker",
"defaultValue" => "now"
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"CustomerID" => "Customer ID",
"WishQuantity" => "Wish Quantity",
"WishDate" => "Wish Date"];
}?>
