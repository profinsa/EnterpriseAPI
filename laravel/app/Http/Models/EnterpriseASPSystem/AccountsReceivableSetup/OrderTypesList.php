<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ordertypes";
protected $gridFields =["OrderTypeID","OrderTypeDescription"];
public $dashboardTitle ="Order Types";
public $breadCrumbTitle ="Order Types";
public $idField ="OrderTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","OrderTypeID"];
public $editCategories = [
"Main" => [

"OrderTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"OrderTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"OrderTypeID" => "Order Type ID",
"OrderTypeDescription" => "Order Type Description"];
}?>
