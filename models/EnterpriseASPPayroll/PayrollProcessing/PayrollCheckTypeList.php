<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollchecktype";
public $gridFields =["CheckTypeID","CheckTypeDescription"];
public $dashboardTitle ="PayrollCheckType";
public $breadCrumbTitle ="PayrollCheckType";
public $idField ="CheckTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CheckTypeID"];
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
