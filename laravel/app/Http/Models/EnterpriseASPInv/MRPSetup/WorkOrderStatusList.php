<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "workorderstatus";
public $dashboardTitle ="WorkOrderStatus";
public $breadCrumbTitle ="WorkOrderStatus";
public $idField ="WorkOrderStatus";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderStatus"];
public $gridFields = [

"WorkOrderStatus" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WorkOrderStatusDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WorkOrderStatus" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderStatusDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkOrderStatus" => "Status",
"WorkOrderStatusDescription" => "Status Description"];
}?>
