<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollitembasis";
protected $gridFields =["PayrollItemBasisID","PayrollItemBasisDescription"];
public $dashboardTitle ="PayrollItemBasis";
public $breadCrumbTitle ="PayrollItemBasis";
public $idField ="PayrollItemBasisID";
public $editCategories = [
"Main" => [

"PayrollItemBasisID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PayrollItemBasisDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PayrollItemBasisID" => "Payroll Item Basis ID",
"PayrollItemBasisDescription" => "Payroll Item Basis Description"];
}?>
