<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "workordertypes";
public $dashboardTitle ="Work Order Types";
public $breadCrumbTitle ="Work Order Types";
public $idField ="WorkOrderTypes";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkOrderTypes"];
public $gridFields = [

"WorkOrderTypes" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WorkOrderTypesDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WorkOrderTypes" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkOrderTypesDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkOrderTypes" => "Type",
"WorkOrderTypesDescription" => "Type Description"];
}?>
