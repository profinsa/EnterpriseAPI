<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customertypes";
protected $gridFields =["CustomerTypeID","CustomerTypeDescription"];
public $dashboardTitle ="Customer Types";
public $breadCrumbTitle ="Customer Types";
public $idField ="CustomerTypeID";
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
