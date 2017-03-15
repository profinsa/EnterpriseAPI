<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgerbalancetype";
protected $gridFields =["GLBalanceType","GLBalanceTypeDescription"];
public $dashboardTitle ="LedgerBalanceType";
public $breadCrumbTitle ="LedgerBalanceType";
public $idField ="GLBalanceType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","GLBalanceType"];
public $editCategories = [
"Main" => [

"GLBalanceType" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBalanceTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"GLBalanceType" => "GL Balance Type",
"GLBalanceTypeDescription" => "GL Balance Type Description"];
}?>
