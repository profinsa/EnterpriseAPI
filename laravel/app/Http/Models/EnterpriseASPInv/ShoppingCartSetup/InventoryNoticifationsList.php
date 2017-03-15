<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorynoticifations";
protected $gridFields =["ItemID","CustomerID","NotificationType","Confirmed","ApprovedBy"];
public $dashboardTitle ="InventoryNoticifations";
public $breadCrumbTitle ="InventoryNoticifations";
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
"NotificationType" => [
"inputType" => "text",
"defaultValue" => ""
],
"Confirmed" => [
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
"CustomerID" => "Customer ID",
"NotificationType" => "Type",
"Confirmed" => "Confirmed",
"ApprovedBy" => "Approved By",
"Approved" => "Approved"];
}?>
