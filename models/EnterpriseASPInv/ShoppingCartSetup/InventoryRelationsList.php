<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryrelations";
protected $gridFields =["ItemID","RelatedItemID","RelatedItemReason"];
public $dashboardTitle ="InventoryRelations";
public $breadCrumbTitle ="InventoryRelations";
public $idField ="ItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ItemID"];
public $editCategories = [
"Main" => [

"ItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"RelatedItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"RelatedItemReason" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ItemID" => "ItemID",
"RelatedItemID" => "RelatedItemID",
"RelatedItemReason" => "RelatedItemReason"];
}?>
