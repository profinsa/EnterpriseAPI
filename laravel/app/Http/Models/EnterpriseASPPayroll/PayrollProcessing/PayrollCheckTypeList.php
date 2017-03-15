<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollchecktype";
public $dashboardTitle ="PayrollCheckType";
public $breadCrumbTitle ="PayrollCheckType";
public $idField ="CheckTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CheckTypeID"];
public $gridFields = [

"CheckTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CheckTypeDescription" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"CheckTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CheckTypeDescription" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CheckTypeID" => "Check Type ID",
"CheckTypeDescription" => "Check Type Description"];
}?>
