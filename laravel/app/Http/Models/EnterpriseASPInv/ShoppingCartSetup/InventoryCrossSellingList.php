<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorycrossselling";
public $dashboardTitle ="InventoryCrossSelling";
public $breadCrumbTitle ="InventoryCrossSelling";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID"];
public $gridFields = [

"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CrossSellItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CrossSellItemReason" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
],
"CrossSellItemPromotion" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
],
"CrossSellItemPromotionEnds" => [
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
"CrossSellItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CrossSellItemReason" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"CrossSellItemPromotion" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"CrossSellItemPromotionEnds" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"ItemID" => "Item ID",
"CrossSellItemID" => "Cross Sell Item ID",
"CrossSellItemReason" => "Reason",
"CrossSellItemPromotion" => "Promotion",
"CrossSellItemPromotionEnds" => "Promotion Ends"];
}?>
