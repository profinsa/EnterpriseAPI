<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorycrossselling";
protected $gridFields =["ItemID","CrossSellItemID","CrossSellItemReason","CrossSellItemPromotion","CrossSellItemPromotionEnds"];
public $dashboardTitle ="InventoryCrossSelling";
public $breadCrumbTitle ="InventoryCrossSelling";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID"];
public $editCategories = [
"Main" => [

"ItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CrossSellItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CrossSellItemReason" => [
"inputType" => "text",
"defaultValue" => ""
],
"CrossSellItemPromotion" => [
"inputType" => "text",
"defaultValue" => ""
],
"CrossSellItemPromotionEnds" => [
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
