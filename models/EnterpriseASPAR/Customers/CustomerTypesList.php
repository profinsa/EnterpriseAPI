<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customertypes";
public $gridFields =["CustomerTypeID","CustomerTypeDescription"];
public $dashboardTitle ="Customer Types";
public $breadCrumbTitle ="Customer Types";
public $idField ="CustomerTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerTypeID"];
public $editCategories = [
"Main" => [

"CustomerTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerTypeID" => "Customer Type ID",
"CustomerTypeDescription" => "Customer Type Description"];
}?>
