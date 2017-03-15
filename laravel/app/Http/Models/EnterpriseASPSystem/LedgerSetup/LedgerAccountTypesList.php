<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgeraccounttypes";
public $gridFields =["GLAccountType"];
public $dashboardTitle ="Ledger Account Types";
public $breadCrumbTitle ="Ledger Account Types";
public $idField ="GLAccountType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","GLAccountType"];
public $editCategories = [
"Main" => [

"GLAccountType" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"GLAccountType" => "GL Account Type"];
}?>
