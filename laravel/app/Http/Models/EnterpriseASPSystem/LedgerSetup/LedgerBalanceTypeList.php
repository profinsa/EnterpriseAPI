<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgerbalancetype";
public $dashboardTitle ="LedgerBalanceType";
public $breadCrumbTitle ="LedgerBalanceType";
public $idField ="GLBalanceType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","GLBalanceType"];
public $gridFields = [

"GLBalanceType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLBalanceTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"GLBalanceType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBalanceTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"GLBalanceType" => "GL Balance Type",
"GLBalanceTypeDescription" => "GL Balance Type Description"];
}?>
