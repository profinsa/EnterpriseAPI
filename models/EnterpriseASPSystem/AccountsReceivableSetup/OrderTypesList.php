<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ordertypes";
public $gridFields =["OrderTypeID","OrderTypeDescription"];
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
