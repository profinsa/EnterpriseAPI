<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventorynoticifations";
public $dashboardTitle ="InventoryNoticifations";
public $breadCrumbTitle ="InventoryNoticifations";
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
"NotificationType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"Confirmed" => [
    "dbType" => "bigint(20)",
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
"CustomerID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"NotificationType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Confirmed" => [
"dbType" => "bigint(20)",
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
"CustomerID" => "Customer ID",
"NotificationType" => "Type",
"Confirmed" => "Confirmed",
"ApprovedBy" => "Approved By",
"Approved" => "Approved"];
}?>
