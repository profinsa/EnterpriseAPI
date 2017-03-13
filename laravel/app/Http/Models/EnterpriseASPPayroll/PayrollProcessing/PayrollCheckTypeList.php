<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollchecktype";
protected $gridFields =["CheckTypeID","CheckTypeDescription"];
public $dashboardTitle ="PayrollCheckType";
public $breadCrumbTitle ="PayrollCheckType";
public $idField ="CheckTypeID";
public $editCategories = [
"Main" => [

"CheckTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CheckTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CheckTypeID" => "Check Type ID",
"CheckTypeDescription" => "Check Type Description"];
}?>